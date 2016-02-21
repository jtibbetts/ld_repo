cp ~/git/lti-models/src/main/resources/rdf/Out.txt lti.ttl
~/rdfconvert-0.4/bin/rdfconvert.sh ~/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/cbegreen/hydra/hydra.jsonld ~/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/cbegreen/hydra/hydra.ttl
cat ~/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/cbegreen/hydra/hydra.ttl > cbe.ttl
cat ~/git/purl_redirector/data/purl.imsglobal.org/vocab/cbe/v1/cbegreen/cbegreen.ttl >> cbe.ttl

