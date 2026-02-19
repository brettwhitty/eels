# Runnable Nextflow Examples

These are hand-tuned Nextflow workflows that can actually be executed,
as opposed to the structural translations in the parent directory.

## ncbi-blastp-runnable.nf

Runnable translation of the Ergatis ncbi-blastp component.

```bash
nextflow run ncbi-blastp-runnable.nf \
    --query_fasta /path/to/queries/*.fasta \
    --database_path /path/to/nr
```

Parameters match the original Ergatis ncbi-blastp.config defaults:
- EXPECT = 1e-5
- FILTER = T
- MATRIX = BLOSUM62
- DATABASE_MATCHES = 150
- DESCRIPTIONS = 150

## Structural vs Runnable

The `.nf` files in `generated/nextflow/` are structural translations that
preserve the complete Ergatis component workflow (all commands, params,
converters). They document what each component does.

The files in this `examples/` directory are simplified, runnable versions
that focus on the core tool execution.
