# Linked Data Repo & Apache Config

## Overview
IMS uses linked data (a.k.a. semantic web) technology for developing certain of its specifications; notably, Learning Tools
Interoperability (LTI), Caliper analytics, and Competency-Based Education (CBE).

This repo contains: 1. the current set of released (LTI, Caliper) and proposed (CBE) ontologies. 2. an Apache configuration that supports
mod_rewrite to implement accepted RDF publishing standards 3. a script that adjusts resource filename conventions to standard format

These are all described in detail below.


## Resources
Linked data requires that definitions of resources be defined using some format supported by the Resource Description Framework (rdf).
These include JSON-LD (JSON for Linked-Data) and Turtle (ttl). These resource descriptions are sometimes called vocabularies (for
simpler, flatter, more primitive definitions) or ontologies (for more structured and articulated definitions).
The underlying assumptions of the repository mechanism described here are as follows: 

1. each resource description is stored in a file with a filename denoting the rdf format being used.
 * this approach is common but not universal--such as storing the resource descriptions in a database

1. accepted extensions are
 	* .jsonld or .json for JSON-LD (jsonld preferred)
	* .ttl for Turtle
	* .html for HTML (human-readable explanation of the resource)

1. the directory structure of the repo mirrors the namespace of the resource.  
 	* for example, the resource /ctx/lis/v2/LineItem is stored in a repo subdirectory that is in /ctx/lis/v2/LineItem
 
1. the resource container (e.g. LineItem) is the preferred filename of the resource
 	* e.g., the LineItem folder might contain LineItem.jsonld, LineItem.ttl, and LineItem.html
 
1. The preferred mechanism for accessing a resource uses content negotiation
	* the GET of the container specifies the resource
	* an HTTP Accept Header specifies the preferred format

1. Alternatively an address can explicitly the particular resource file
	* e.g., /ctx/lis/v2/LineItem/LineItem.ttl
	* however this is not a best practice
	
## Serving RDF resources with Apache
The definitive article on serving RDF resources is at [Best Practice Recipes for Publishing RDF Vocabularies](https://www.w3.org/TR/swbp-vocab-pub/).  In particular we follow a recipe quite similar to [Recipe 3. Extended configuration for a 'slash namespace'](https://www.w3.org/TR/swbp-vocab-pub/#recipe3).

In general, an incoming Apache request is checked for the existence of files within the specified resoure.  target subdirectory that match first the Accept headers and, then if further needs be, to prioritize them by the conventions described in the bulleted assumptions above.  Once an existing file is found that most closely matches

In general the following steps are taken:

1. an incoming Apache request for a resource is checked if it already addresses a specific resource file by name, if so we're done.
2. a resource location that maps to a directory then attempts to match a file within that directory that matches the criteria defined in the bulleted assumptions above.
	* priority is given to files that match the Accept header
	* if the Accept is jsonld or json, special consideration is given to the particular resource JSON_LD_CONTEXT.jsonld.  This is an artifact of [Greg's Semantic Tools](https://github.com/gmcfall/semantictools.git).
	* priority is then given to resources in the order: jsonld, ttl, html
3. if a target existing file is found the URL is rewritten with mod_rewrite.



