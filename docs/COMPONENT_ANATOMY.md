# Component Anatomy: wait

**Purpose:** Demonstration of Ergatis component structure using the simplest possible component.

**Component:** `wait` - Utility component that sleeps for a specified time  
**Location:** `ergatis-git/components/wait/`

## Component Files

```
wait/
├── wait.config       # Configuration template (INI format)
├── wait.xml          # Component template (main workflow)
├── wait.i1.xml       # Iterator 1 template (per-element processing)
├── wait.i2.xml       # Iterator 2 template (optional second iterator)
└── wait.tmpl         # Legacy template (unused)
```

## Configuration File: wait.config

**Format:** INI with placeholder variables (`$;KEY$;`)

### Key Sections

**[interface]**
```ini
classification = utility
```
Component category for UI organization.

**[parameters]**
```ini
$;TIME$; = 10
```
Component-specific parameters. The `wait` component has one parameter: sleep time in seconds.

**[input]**
```ini
$;INPUT_FILE_LIST$; = 
$;INPUT_FILE$; = 
$;INPUT_DIRECTORY$; = 
$;INPUT_EXTENSION$; = fsa
```
Input specification - supports three modes:
- Single file (`INPUT_FILE`)
- List of files (`INPUT_FILE_LIST`)
- Directory scan (`INPUT_DIRECTORY` + `INPUT_EXTENSION`)

**[output]**
```ini
$;OUTPUT_TOKEN$; = default
$;OUTPUT_DIRECTORY$; = $;REPOSITORY_ROOT$;/output_repository/$;COMPONENT_NAME$;/$;PIPELINEID$;_$;OUTPUT_TOKEN$;
```
Output directory structure using standard Ergatis layout.

**[component]**
```ini
$;COMPONENT_NAME$; = wait
$;WORKFLOW_REPOSITORY$; = $;REPOSITORY_ROOT$;/workflow/runtime/$;COMPONENT_NAME$;/$;PIPELINEID$;_$;OUTPUT_TOKEN$;
$;TEMPLATE_XML$; = $;DOCS_DIR$;/wait.xml
$;ITERATOR1$; = i1
$;ITERATOR1_XML$; = $;DOCS_DIR$;/wait.$;ITERATOR1$;.xml
$;ITERATOR2$; = i2
$;ITERATOR2_XML$; = $;DOCS_DIR$;/wait.$;ITERATOR2$;.xml
$;GROUP_COUNT$; = 150
$;NODISTRIB$; = 0
```

Key concepts:
- **TEMPLATE_XML** - Main component workflow template
- **ITERATOR1/2** - Iterator names and templates
- **GROUP_COUNT** - Parallelization factor (150 groups)
- **NODISTRIB** - Distribution flag (0 = distribute to grid)

**[include]**
```ini
$;PROJECT_CONFIG$;=
```
Include project-wide configuration (paths, database connections, etc.)

## Component Template: wait.xml

**Structure:**
```xml
<commandSetRoot>
  <commandSet type="serial">
    <!-- Preprocessing -->
    <command>mkdir output directory</command>
    <command>mkdir temp directory</command>
    
    <!-- Iterator -->
    <INCLUDE file="file_iterator_template.xml">
    
    <!-- Postprocessing -->
    ...
  </commandSet>
</commandSetRoot>
```

### Preprocessing Steps

**Create output directory:**
```xml
<command>
  <type>RunUnixCommand</type>
  <executable>mkdir</executable>
  <arg>-p -m 777 $;OUTPUT_DIRECTORY$;</arg>
</command>
```

**Create temp directory:**
```xml
<command>
  <type>RunUnixCommand</type>
  <executable>mkdir</executable>
  <arg>-p -m 777 $;TMP_DIR$;</arg>
</command>
```

### Iterator Include

```xml
<INCLUDE file="$;DOCS_DIR$;/file_iterator_template.xml" 
         keys="$;ITERATOR_NAME$;=ITERATOR1,$;ITERATOR_XML$;=ITERATOR1_XML">
```

This includes a generic file iterator template that:
1. Builds list of input files
2. Batches them into groups (GROUP_COUNT)
3. Creates parallel execution structure
4. References the iterator template (wait.i1.xml) for each element

## Iterator Template: wait.i1.xml

**Purpose:** Defines processing for a single input element.

```xml
<commandSetRoot>
  <commandSet type="serial">
    <command>
      <type>RunUnixCommand</type>
      <name>wait</name>
      <executable>$;BIN_DIR$;/spin_wait</executable>
      <param>
        <key>--time</key>
        <value>$;TIME$;</value>
      </param>
      <param>
        <key>stdout</key>
        <value>$;OUTPUT_DIRECTORY$;/$;ITERATOR_NAME$;/g$;GROUP_NUMBER$;/$;I_FILE_BASE$;.$;COMPONENT_NAME$;.stdout</value>
      </param>
      <param>
        <key>stderr</key>
        <value>$;OUTPUT_DIRECTORY$;/$;ITERATOR_NAME$;/g$;GROUP_NUMBER$;/$;I_FILE_BASE$;.$;COMPONENT_NAME$;.stderr</value>
      </param>
    </command>
  </commandSet>
</commandSetRoot>
```

### Iterator Variables

Variables injected by the iterator framework:

- **$;ITERATOR_NAME$;** - Iterator identifier (i1, i2, etc.)
- **$;GROUP_NUMBER$;** - Batch number (1 to GROUP_COUNT)
- **$;I_FILE_BASE$;** - Input filename without extension
- **$;I_FILE_PATH$;** - Full path to input file
- **$;I_FILE_NAME$;** - Input filename with extension
- **$;I_FILE_EXT$;** - Input file extension

### Output Structure

```
$;OUTPUT_DIRECTORY$;/
  i1/                    # Iterator 1
    g1/                  # Group 1
      file1.wait.stdout
      file1.wait.stderr
      file2.wait.stdout
      file2.wait.stderr
    g2/                  # Group 2
      file3.wait.stdout
      ...
```

## Instantiation Process

### 1. Configuration Expansion

**Input:** `wait.config` (template with placeholders)  
**Tool:** `replace_config_keys`  
**Output:** `wait.token.final.config` (expanded values)

Example expansion:
```
$;COMPONENT_NAME$; = wait
$;OUTPUT_TOKEN$; = default
$;PIPELINEID$; = 12345

$;OUTPUT_DIRECTORY$; = $;REPOSITORY_ROOT$;/output_repository/$;COMPONENT_NAME$;/$;PIPELINEID$;_$;OUTPUT_TOKEN$;
↓
$;OUTPUT_DIRECTORY$; = /usr/local/projects/db1/output_repository/wait/12345_default
```

### 2. Template Expansion

**Input:** `wait.xml` + `wait.token.final.config`  
**Tool:** `replace_template_keys`  
**Output:** `component.xml` (instantiated workflow)

Placeholders replaced with actual values from config.

### 3. Iterator Generation

**Input:** List of input files  
**Tool:** `create_iterator_groups`  
**Process:**
1. Read input file list
2. Batch into groups (GROUP_COUNT = 150)
3. For each group, create group XML
4. For each element in group, instantiate iterator template

**Output Structure:**
```
workflow/runtime/wait/12345_default/
  component.xml          # Main component workflow
  i1/
    i1.xml              # Iterator 1 master
    g1/
      g1.xml            # Group 1 master
      file1.xml         # Element 1 (from wait.i1.xml)
      file2.xml         # Element 2
    g2/
      g2.xml
      file3.xml
      ...
```

### 4. Execution

**Workflow engine** (Workflow::RunWorkflow) executes:
1. component.xml (serial)
   - Create directories
   - Execute i1.xml (parallel groups)
     - Each group executes serially
       - Each element runs spin_wait

## Key Concepts

### Placeholder Variables

**Syntax:** `$;KEY$;`

**Types:**
- **Global** - Defined in project.config (REPOSITORY_ROOT, BIN_DIR)
- **Component** - Defined in component.config (COMPONENT_NAME, OUTPUT_TOKEN)
- **Iterator** - Injected at runtime (GROUP_NUMBER, I_FILE_BASE)
- **Pipeline** - Injected by pipeline (PIPELINEID)

### Variable Expansion Order

1. **Project config** - Global paths and settings
2. **Component config** - Component-specific values
3. **User overrides** - Command-line or GUI overrides
4. **Iterator variables** - Runtime injection during group creation

### Iterator Pattern

**Purpose:** Parallelize processing across multiple inputs

**Mechanism:**
1. **Input list** - Files to process
2. **Batching** - Divide into groups (GROUP_COUNT)
3. **Distribution** - Each group can run on different compute node
4. **Element processing** - Iterator template applied to each file

**Parallelization:**
- Groups execute in parallel (distributed)
- Elements within group execute serially
- Configurable via GROUP_COUNT and NODISTRIB

### File-Based Subflows

**Concept:** XML files reference other XML files

```xml
<INCLUDE file="path/to/template.xml" keys="KEY1=VALUE1,KEY2=VALUE2">
```

**Benefits:**
- Reusable templates
- Modular composition
- Dynamic workflow generation

## CWL Equivalent

```yaml
class: CommandLineTool
baseCommand: spin_wait
inputs:
  time:
    type: int
    inputBinding:
      prefix: --time
outputs:
  stdout: stdout
  stderr: stderr
```

With scatter:
```yaml
class: Workflow
inputs:
  input_files: File[]
  time: int
steps:
  wait:
    run: wait.cwl
    scatter: input_file
    in:
      input_file: input_files
      time: time
```

## Workflow Architecture

### 6-Level XML Hierarchy

Based on `ergatis-git/doc/workflowxml.txt`:

1. **Skeleton XML** - Saved pipeline template (component ordering + config)
2. **Pipeline XML** - Instantiated workflow with PIPELINE_ID
3. **Component XML** - Top-level component steps (created during pipeline execution)
4. **Iterator XML** - Lists all groups/batches for parallel distribution
5. **Group XML** - Serial execution of elements within one batch
6. **Element XML** - Single input file processing (the actual compute work)

### Execution Flow

**Pipeline level:**
- Skeleton XML → Pipeline XML (with PIPELINE_ID)
- Pipeline XML references component XML files as subflows

**Component level:**
- Component XML created during pipeline execution
- Contains setup/pre/post-processing steps
- Includes steps to build iterator groups and iterator XML

**Iterator level:**
- Iterator XML lists all groups (parallel execution)
- Groups can be distributed to compute grid or run locally
- GROUP_COUNT determines number of batches
- `create_iterator_groups` handles batching logic

**Group level:**
- Group XML executes serially on single compute node
- Creates element XML from iterator template
- One element XML per input file in the group

**Element level:**
- Element XML processes single input file
- Where actual compute work happens
- Generated from iterator template (e.g., `wu-blastp.i1.xml`)

### Key Characteristics

1. **Modular templates** - Reusable iterator patterns
2. **Flexible batching** - GROUP_COUNT + max_elements controls distribution
3. **Standard directory structure** - Predictable output locations
4. **Variable inheritance** - Project → Component → Iterator
5. **File-based subflows** - Composable workflow fragments
6. **Two-phase execution** - Template expansion before execution
7. **Placeholder syntax** - `$;KEY$;` for variable substitution
8. **Runtime generation** - Component/iterator XML created during execution

## Files for Reference

- `ergatis-git/components/wait/wait.config`
- `ergatis-git/components/wait/wait.xml`
- `ergatis-git/components/wait/wait.i1.xml`
- `ergatis-git/docs/file_iterator_template.xml`
- `ergatis-git/src/perl/replace_config_keys`
- `ergatis-git/src/perl/replace_template_keys`
- `ergatis-git/src/perl/create_iterator_groups`

---

**Next:** Analyze a real component (blast, glimmer3) with actual tool execution and BSML conversion.
