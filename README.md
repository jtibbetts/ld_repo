# Linked Data Repo & Apache Config

## Overview
IMS uses linked data (a.k.a. semantic web) technology for developing certain of
its specifications; notably, Learning Tools Interoperability (LTI), Caliper
analytics, and Competency-Based Education (CBE).  

This repo contains:
  1. the current set of released (LTI, Caliper) and proposed (CBE) ontologies.
  2. an Apache configuration that supports mod_rewrite to implement accepted RDF
  publishing standards
  3. a script that adjusts resource filename conventions to standard format

These are all described in detail below.

## Resources
IMS uses linked data (a.k.a. semantic web) technology for developing certain of
its specifications; notably, Learning Tools Interoperability (LTI), Caliper
analytics, and Competency-Based Education (CBE).  Linked data requires that
definitions of resources be defined using some format supported by
the Resource Description Framework (rdf).  These include JSON-LD (JSON for
Linked-Data) and Turtle (ttl).  These resource descriptions are sometimes called
vocabularies (for simpler, flatter, more primitive definitions) or ontologies
(for more structured and articulated definitions).

The resource descriptions are stored in the repo at purl.imsglobal.org.  Each
type of resource is stored within either a JSON-LD or Turtle file or both.  In addition, a
repo location may also contain an HTML file for a human-readable description of
the vocabulary / ontology.

The directory structure of the resource files is based on a namespace hierarchy.

For example: resource files about /ctx/lis/v2/Lineitem are contained in the subdirectory
at file location: purl.imsglobal.org/ctx/lis/v2/Lineitem.  Note that the
best practice for addressing a resource is denoting the *directory* that it's in
rather the specific filename within that directory, although one can always
directly reference the specific file.  The best practice it to use HTTP
content negotiation (using the HTTP Accept header) to specify which resource
format to access.

Resources within the target directory can be named with file extensions: jsonld,
json (interpreted the same way as jsonld), ttl, or html.

The recommended filename conventions are that the resource filename should
be the same as its container.  Thus the /ctx/lis/v2/LineItem subdirectory
might contain files: LineItem.jsonld and LineItem.html.
