# Ergatis Lite Format Specification

**Author:** Brett Whitty, JCVI, 2007  
**Design:** Mathematical ordered/unordered list syntax + Perl Data::Dumper extensions

## Overview

Ergatis Lite uses a bracket-based syntax designed for command-line one-liners. The format maps directly to mathematical concepts and is familiar to Perl developers.

## Core Syntax

### Execution Blocks

```
()  = Ordered list (serial execution - order matters)
{}  = Unordered set (parallel execution - order doesn't matter)
<>  = Component (atomic workflow element)
```

### Component Definition

```
<component_name.token:key1=value1;key2=value2>
```

**Parts:**
- `component_name` - Name of the Ergatis component
- `.token` - Optional unique identifier (auto-generated if omitted)
- `:key=value` - Configuration key-value pairs (semicolon-separated)

**Special Values:**
- Values should use URL encoding for: `;`, `=`, whitespace
- `@URL://path/to/file` - Remote file retrieval (supports .zip, .tar.gz, .tgz, .gz, .bz2)
- `&key=/path/to/list.txt` - Polymorphism: create component set from list
- `[component.token]` - Reference another component's output (auto-matching)
- `*IN=[component.token]` - Automatic input matching
- `KEY=value` - Uppercase key references global variable

### Examples

**Simple serial pipeline:**
```
(<component1>, <component2>, <component3>)
```

**Parallel execution:**
```
{<blast1>, <blast2>, <blast3>}
```

**Mixed serial and parallel:**
```
(
    <split_fasta>,
    {
        <blast.db1:database=/path/to/db1>,
        <blast.db2:database=/path/to/db2>
    },
    <merge_results>
)
```

**Component with configuration:**
```
<blastp.custom:input_file=/data/query.fsa;database=/db/nr;evalue=1e-5>
```

## Advanced Features

### Component Inheritance

**Absolute path to config file:**
```
</absolute/path/to/component.token.config:key=value>
```

Uses the specified config file as base, with key-value pairs overriding defaults.

### Polymorphism - Component Sets

**Generate multiple components from a list:**
```
<component:&database=/path/to/database_list.txt>
```

The `&` prefix creates a set of components, one for each value in the list file.

### Automatic Output → Input Matching

**Reference another component's output:**
```
<component2:input_file_list=[component1.token]>
```

The `[]` brackets invoke automatic output→input matching based on the input type.

**Automatic matching with special key:**
```
<component2:*IN=[component1.token]>
```

The special key `*IN` invokes automatic output→input matching without specifying the key.

### Global Variables

**Reference global variables:**
```
<component:KEY=global_variable>
```

Uppercase keys indicate the value is a global variable (defined in template header).

### Template Includes

**Include Ergatis Lite template:**
```
<INCLUDE:/path/to/template_file.txt>
```

Recursively parse and include another Ergatis Lite template (bracket syntax).

**Include Ergatis XML template:**
```
<INCLUDE:/path/to/component.xml>
```

Parse an existing Ergatis XML template and convert it to lite format inline.

**Bidirectional conversion:**
- Ergatis Lite → XML (for execution)
- Ergatis XML → lite (for editing/composition)

This allows mixing legacy XML templates with new lite syntax.

### Remote Files & URI Handlers

```
<component:input_file=@protocol://server/path/file>
```

Automatically retrieve remote resources using URI handlers.

**Extensible URI system:**
- Any URI scheme supported (like modern OSes/browsers)
- Define custom protocol handlers
- Built-in handlers: `ftp://`, `http://`, `https://`
- Add your own: `s3://`, `gs://`, `hdfs://`, etc.

**Automatic archive extraction:**
- `.zip`, `.tar.gz`, `.tgz`, `.gz`, `.bz2`
- Detected by file extension
- Extracted to pipeline working directory

**Examples:**
```
# Built-in protocols
<blast:database=@ftp://ftp.ncbi.nlm.nih.gov/blast/db/nr.tar.gz>
<component:input=@http://server/data.fsa>

# Custom handlers (user-defined)
<component:input=@s3://bucket/path/data.fsa>
<component:input=@gs://bucket/path/data.fsa>
<component:input=@hdfs://namenode/path/data.fsa>
```

**Handler registration:**
Define custom protocol handlers for your environment. The system will:
1. Parse the URI scheme
2. Call the registered handler
3. Stage the file to working directory
4. Pass the local path to the component

### Data Staging

**Global variables for remote data:**
```
# remote_input_file=@ftp://server/path/data.fsa
# remote_input_archive=@http://server/path/data.tgz
# s3_database=@s3://my-bucket/databases/nr.tar.gz
```

Define remote data sources in template header, reference in components.

### Auto-Generated Tokens

If no token is specified, components are auto-numbered:
```
<blastp>  → blastp.default_1
<blastp>  → blastp.default_2
```

### Global Variables

Template files can define global variables in header comments:
```
# input_file=/path/to/data.fsa
# database=/path/to/db
```

These can be referenced in component definitions.

## Template File Format

```
# Global variable definitions (optional)
# key=value

(
    <component1:param=$key>,
    {
        <component2>,
        <component3>
    },
    <component4>
)
```

## Mathematical Foundation

The syntax directly reflects workflow semantics:

- **Ordered list `()`** - Elements must execute in sequence (dependencies)
- **Unordered set `{}`** - Elements can execute in any order (parallelizable)
- **Nesting** - Arbitrary depth for complex workflows

This maps naturally to:
- Directed Acyclic Graphs (DAGs)
- Dependency trees
- Parallel execution strategies

## Comparison to Other Formats

**vs XML:**
- More concise (one-liner capable)
- Human-readable
- Less verbose

**vs YAML:**
- More structured (explicit serial/parallel)
- Mathematical foundation
- Familiar to Perl developers (Data::Dumper-like)

## Implementation Notes

The parser uses recursive descent to handle nested structures:

1. Strip outer brackets
2. Identify type (serial/parallel/component)
3. Recursively parse contents
4. Build workflow tree

Components are instantiated as objects that can:
- Store configuration attributes
- Reference other components
- Auto-match outputs to inputs (planned feature)

## Design Philosophy

**Minimal syntax for workflow experts:**
- Brackets convey execution semantics
- No boilerplate required
- Command-line friendly
- Extensible without breaking existing syntax

**Built by a workflow expert for workflow experts.**

---

**See also:**
- `template_file.txt` - Example template
- `ErgatisPipelineTemplate.pm` - Parser implementation
- `README.md` - Project overview
