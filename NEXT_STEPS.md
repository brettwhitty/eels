# EELS Next Steps - Organized Plan

## Current State (2026-02-19)

### Completed
✅ Phase 1: Initial extraction (converters, contributors, architecture)
✅ Phase 2: Structured analysis (components, iterators, workflows)  
✅ Phase 3: Converter documentation (65 manpages extracted)

### Data Assets Created
- `data/converter_catalog.json` - 67 BSML converters metadata
- `data/component_summary.json` - 362 components aggregate stats
- `data/components/*.json` - Individual component metadata (362 files)
- `data/iterator_catalog.json` - 254 components with iterators
- `data/component_catalog_summary.json` - Complete inventory
- `data/workflow_catalog.json` - 56 workflows, 108 XML files
- `data/contributors.json` - 28 contributors
- `data/manpages/*.txt` - 65 converter manpages

### Documentation Created
- `docs/BSML_CONVERTER_CATALOG.md` - Converter summary (1671 lines)
- `docs/COMPONENT_ANATOMY.md` - Complete component walkthrough (403 lines)
- `docs/ERGATIS_LITE_SPEC.md` - S-expression format spec
- `docs/CONVERTER_REFERENCE.md` - Comprehensive converter guide
- `docs/converters/blast2bsml.md` - BLAST converter analysis
- `docs/converters/glimmer32bsml.md` - Glimmer3 converter
- `docs/converters/aragorn2bsml.md` - ARAGORN converter
- `CONTRIBUTORS.md` - Attribution document
- `README.md`, `STATUS.md`, `WORKPLAN.md`

## Remaining Work

### Phase 4: BSML Schema Analysis

**Goal:** Document BSML XML structure and semantics

**Tasks:**
1. Extract BSML examples from converter outputs
2. Identify common BSML elements (Sequence, Feature, Alignment, etc.)
3. Document coordinate systems and conventions
4. Map BSML to modern formats (GFF3, JSON)

**Output:** `docs/BSML_SCHEMA.md`

**Estimated effort:** 2-4 hours

### Phase 5: Translation Strategy

**Goal:** Map Ergatis primitives to modern workflow languages and standards

**Tasks:**
1. Define primitive mappings:
   - Component → CWL CommandLineTool / Nextflow process / WDL task / BCO step
   - Iterator → scatter/gather patterns
   - Pipeline → workflow composition / BCO pipeline
2. Document variable expansion strategies
3. Evaluate Ergatis Lite S-expression as native format
4. Map to BioCompute Object (BCO) IEEE standard

**Output:** `docs/TRANSLATION_GUIDE.md`

**Estimated effort:** 4-6 hours

### Phase 6: Proof-of-Concept Translations

**Goal:** Validate translation approach with working examples

**Tasks:**
1. Select 3 simple components (wait, split_multifasta, blast)
2. Translate each to CWL, Nextflow, WDL, BCO
3. Test translations execute correctly (where applicable)
4. Document translation patterns

**Output:** `examples/{cwl,nextflow,wdl,bco}/` with working examples

**Estimated effort:** 8-12 hours

### Phase 7: Final Documentation

**Goal:** Complete knowledge preservation

**Tasks:**
1. Architecture overview document
2. Component reference guide
3. Workflow composition patterns
4. Historical context and design decisions
5. Archive package creation

**Output:** Complete documentation set + archive

**Estimated effort:** 4-6 hours

## Immediate Priorities (Next Session)

1. **BSML Schema Analysis** - Extract and document BSML structure
2. **Translation Guide** - Map primitives to modern formats
3. **Update STATUS.md** - Reflect current progress

## Success Metrics

- [ ] All converters documented (65/91 have manpages)
- [ ] All components cataloged (362/362 ✓)
- [ ] All workflows cataloged (56/56 ✓)
- [ ] BSML schema documented
- [ ] Translation guide complete
- [ ] 3+ working proof-of-concept translations
- [ ] Archive package created

## Notes

- Focus on knowledge extraction, not running code
- Leverage existing manpages and JSON data
- User (Brett) is domain expert - ask when needed
- Write minimal code - batch processing only
