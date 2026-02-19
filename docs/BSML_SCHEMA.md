# BSML Schema Reference

## Overview

BSML (Bioinformatic Sequence Markup Language) is an XML-based format developed at TIGR for representing biological sequences, features, and analysis results. It served as the primary data interchange format in Ergatis workflows.

## Historical Context

- **Developed:** TIGR/JCVI, early 2000s
- **Purpose:** Unified representation of genomic data and analysis results
- **Scope:** Sequences, features, alignments, analysis metadata
- **Successor:** Replaced by formats like GFF3, but BSML's hierarchical model influenced modern standards

## Core Design Principles

1. **Hierarchical Structure:** Sequences contain features, features contain locations
2. **Analysis Provenance:** Every element tracks its computational source
3. **Cross-References:** Extensive linking between sequences, features, and external databases
4. **Extensibility:** Attribute elements allow arbitrary key-value metadata

## Document Structure

```xml
<?xml version="1.0"?>
<Bsml>
  <Definitions>
    <Sequences>
      <Sequence>...</Sequence>
    </Sequences>
    <Tables>
      <Seq-pair-alignment>...</Seq-pair-alignment>
    </Tables>
  </Definitions>
  <Research>
    <Analyses>
      <Analysis>...</Analysis>
    </Analyses>
  </Research>
</Bsml>
```

## Primary Elements

### Sequence

Represents a biological sequence (DNA, RNA, protein).

**Key attributes:**
- `id` - Unique identifier
- `title` - Human-readable name
- `length` - Sequence length in residues
- `molecule` - Type: dna, rna, aa (amino acid)
- `class` - Sequence class: assembly, contig, transcript, polypeptide

**Child elements:**
- `<Seq-data>` - Actual sequence data (optional, often external)
- `<Feature-tables>` - Annotation features
- `<Attribute>` - Metadata key-value pairs
- `<Cross-reference>` - Links to external databases

**Example:**
```xml
<Sequence id="seq_1" title="gene_1" length="1500" molecule="dna" class="assembly">
  <Attribute name="organism" content="Escherichia coli"/>
  <Feature-tables>
    <Feature-table>
      <Feature id="feat_1" class="gene">
        <Interval-loc startpos="0" endpos="1499"/>
      </Feature>
    </Feature-table>
  </Feature-tables>
</Sequence>
```

### Feature

Represents an annotated region on a sequence.

**Key attributes:**
- `id` - Unique identifier
- `class` - Feature type: gene, CDS, exon, tRNA, rRNA, repeat_region, etc.
- `title` - Feature name/label

**Child elements:**
- `<Interval-loc>` - Genomic coordinates
- `<Attribute>` - Feature properties (gene name, product, EC number, etc.)
- `<Qualifier>` - Additional qualifiers

**Common feature classes:**
- `gene` - Gene locus
- `CDS` - Coding sequence
- `exon` - Exon region
- `tRNA` - Transfer RNA
- `rRNA` - Ribosomal RNA
- `repeat_region` - Repetitive element
- `signal_peptide` - Signal peptide
- `transmembrane_region` - Transmembrane domain

**Example:**
```xml
<Feature id="feat_cds_1" class="CDS">
  <Interval-loc startpos="100" endpos="1400" complement="0"/>
  <Attribute name="gene_product_name" content="hypothetical protein"/>
  <Attribute name="EC" content="1.2.3.4"/>
</Feature>
```

### Interval-loc

Defines genomic coordinates for features.

**Key attributes:**
- `startpos` - Start position (0-based)
- `endpos` - End position (0-based, exclusive)
- `complement` - Strand: 0 (forward), 1 (reverse)

**Coordinate system:**
- **0-based, half-open intervals:** [start, end)
- Start position is inclusive, end position is exclusive
- Example: startpos="0" endpos="100" represents first 100 bases

### Seq-pair-alignment

Represents pairwise sequence alignments (BLAST, FASTA, etc.).

**Key attributes:**
- `refseq` - Reference sequence ID
- `compseq` - Comparison sequence ID
- `method` - Alignment method (blastp, blastn, tblastn, etc.)

**Child elements:**
- `<Seq-pair-run>` - Individual HSP (High-scoring Segment Pair)
- `<Attribute>` - Alignment statistics (percent_identity, percent_coverage, etc.)

**Example:**
```xml
<Seq-pair-alignment refseq="query_1" compseq="subject_1">
  <Attribute name="percent_identity" content="85.5"/>
  <Attribute name="percent_coverage" content="92.3"/>
  <Seq-pair-run>
    <Attribute name="p_value" content="1e-50"/>
    <Attribute name="percent_identity" content="85.5"/>
    <Attribute name="percent_similarity" content="90.2"/>
  </Seq-pair-run>
</Seq-pair-alignment>
```

### Seq-pair-run

Represents a single HSP within an alignment.

**Key attributes:**
- `refpos` - Start position on reference sequence
- `runlength` - Length of alignment
- `refcomplement` - Reference strand (0/1)
- `comppos` - Start position on comparison sequence
- `comprunlength` - Length on comparison sequence
- `compcomplement` - Comparison strand (0/1)

**Child elements:**
- `<Attribute>` - HSP statistics (p_value, percent_identity, etc.)

### Analysis

Tracks computational analysis provenance.

**Key attributes:**
- `id` - Unique identifier
- `sourcename` - Tool/program name (e.g., "blastp", "glimmer3")

**Child elements:**
- `<Attribute>` - Analysis parameters and metadata

**Example:**
```xml
<Analysis id="blast_analysis_1" sourcename="blastp">
  <Attribute name="version" content="2.2.26"/>
  <Attribute name="database" content="nr"/>
  <Attribute name="evalue_cutoff" content="1e-5"/>
</Analysis>
```

### Attribute

Generic key-value metadata container.

**Key attributes:**
- `name` - Attribute key
- `content` - Attribute value

**Common attributes:**
- Sequences: organism, topology, genetic_code
- Features: gene_product_name, gene_symbol, EC, GO
- Alignments: percent_identity, percent_coverage, percent_similarity, p_value, e_value

### Cross-reference

Links to external databases.

**Key attributes:**
- `database` - Database name (e.g., "TIGR_moore", "UniProt", "GO")
- `identifier` - Database-specific ID
- `identifier-type` - ID type (e.g., "locus", "accession")

**Example:**
```xml
<Cross-reference database="UniProt" identifier="P12345" identifier-type="accession"/>
```

## Common Converter Patterns

### Tool Output → BSML

Ergatis converters transform tool-specific outputs into BSML:

**Alignment tools:**
- `blast2bsml` - BLAST raw output → BSML Seq-pair-alignment
- `hmmpfam2bsml` - HMMer output → BSML with domain features
- `aat2bsml` - AAT output → BSML alignments

**Gene prediction:**
- `glimmer32bsml` - Glimmer3 predictions → BSML gene features
- `genemark2bsml` - GeneMark predictions → BSML CDS features
- `augustus2bsml` - Augustus predictions → BSML gene models

**RNA prediction:**
- `tRNAscan-SE2bsml` - tRNAscan-SE → BSML tRNA features
- `RNAmmer2bsml` - RNAmmer → BSML rRNA features

**Functional annotation:**
- `hmmpfam2bsml` - Pfam domains → BSML features with GO terms
- `tmhmm2bsml` - TMHMM → transmembrane_region features
- `signalp2bsml` - SignalP → signal_peptide features

### BSML → Other Formats

- `bsml2fasta` - Extract sequences from BSML
- `bsml2gff3` - Convert BSML features to GFF3
- `bsml2chado` - Load BSML into Chado database
- `bsml2genbank` - Generate GenBank flat files

## Converter Statistics

From 65 documented converters:
- **To BSML:** 45+ converters (tool outputs → BSML)
- **From BSML:** 8+ converters (BSML → other formats)
- **BSML processing:** 12+ converters (BSML → modified BSML)

## Coordinate System Details

BSML uses **0-based, half-open intervals** (like Python slicing):

```
Sequence: ATCGATCG
Positions: 01234567

Feature at positions 2-5:
  startpos="2" endpos="5"
  Represents: CGA (positions 2, 3, 4)
```

**Strand representation:**
- `complement="0"` - Forward strand (+)
- `complement="1"` - Reverse strand (-)

**For reverse strand features:**
- Coordinates still in forward orientation
- `complement="1"` indicates reverse strand

## Metadata Conventions

### Sequence attributes
- `organism` - Organism name
- `topology` - linear, circular
- `genetic_code` - NCBI genetic code table number
- `molecule` - dna, rna, aa

### Feature attributes
- `gene_product_name` - Protein product description
- `gene_symbol` - Gene name/symbol
- `EC` - Enzyme Commission number
- `GO` - Gene Ontology term
- `locus_tag` - Systematic locus identifier

### Alignment attributes
- `percent_identity` - Sequence identity percentage
- `percent_coverage` - Query coverage percentage
- `percent_similarity` - Sequence similarity percentage
- `p_value` - Statistical significance (P-value)
- `e_value` - Expect value

## BSML in Ergatis Workflows

**Typical flow:**
1. Input sequences (FASTA) → `fasta2bsml`
2. Analysis tool execution → raw output
3. Converter → BSML with features/alignments
4. Downstream processing (filtering, merging)
5. Final output → `bsml2gff3`, `bsml2genbank`, or database load

**Advantages:**
- Unified format across diverse tools
- Preserves analysis provenance
- Supports complex feature hierarchies
- Enables workflow composition

**Challenges:**
- XML verbosity (large file sizes)
- Parsing overhead
- Tool-specific BSML dialects
- Limited adoption outside TIGR/JCVI

## Modern Equivalents

BSML concepts map to modern formats:

| BSML Element | Modern Equivalent |
|--------------|-------------------|
| Sequence + Features | GFF3 + FASTA |
| Seq-pair-alignment | BLAST XML, SAM/BAM |
| Analysis provenance | BioCompute Object |
| Cross-references | Ontology annotations |
| Hierarchical features | GFF3 parent/child |

## References

- TIGR/JCVI Ergatis documentation (2003-2008)
- BSML DTD specifications
- Converter source code and manpages
- Production workflow configurations

## See Also

- `CONVERTER_REFERENCE.md` - Complete converter catalog
- `COMPONENT_ANATOMY.md` - Component structure
- `TRANSLATION_GUIDE.md` - Format translations
