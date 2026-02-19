#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: wga_maf2tree
// Generated from Ergatis component JSON by EELS

params {
    fasta_file = ''
    maf_file = ''
    newick_utilities = ''
    output_directory = ''
    output_tree_file = ''
    phylomark_dir = ''
    rasterizer_path = ''
    tmp_dir = ''
}

process fix_maf {
    script:
    """
    perl -ne 's/^s\s+[^\.]+\.(\S+)/s $1/;print'  stdin ${params.maf_file} \
        1>${params.output_directory}/fixed.maf
    """
}

process create_fasta_dir {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/fasta
    """
}

process create_fasta_dir {
    script:
    """
    /usr/bin/perl  -0777 -ne '@f = split(/\n>/); for $fsa (@f){$fsa=~s/^>//;$n=$1 if($fsa=~/^(\S+)/); open(O,">${params.tmp_dir}/fasta/$n.fsa");print O ">".$fsa."\n";close(O); print "$n.fsa\n";}' stdin ${params.fasta_file}
    """
}

process create_tree {
    script:
    """
    cd ${params.output_directory};source ${params.phylomark_dir}/phylomark_env.sh;${params.phylomark_dir}/Phylomark_prep.py --input-maf ${params.maf_file} --fasta-dir ${params.tmp_dir}/fasta --tmp-dir ${params.tmp_dir}
    """
}

process Move_file {
    script:
    """
    /bin/mv ${params.output_directory}/wga.tree ${params.output_tree_file}
    """
}

process Convert_newick_tree_to_svg {
    script:
    """
    ${params.newick_utilities}/nw_display  -s -w 950 -b 'opacity:0' -l 'font-size:large' ${params.output_tree_file} > ${params.output_tree_file}.svg
    """
}

process Convert_newick_tree_to_pdf {
    script:
    """
    ${params.rasterizer_path}  ${params.output_tree_file}.svg pdf 1000 1000
    """
}

workflow {
    // Serial execution chain
    fix_maf()
    create_fasta_dir()
    create_fasta_dir()
    create_tree()
    Move_file()
    Convert_newick_tree_to_svg()
    Convert_newick_tree_to_pdf()
}
