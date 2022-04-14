# Proto Gen

This is an example repository with scripts and GitHub workflows intended to show
how proto files can be generated via scripts that use Docker and are shareable
between devs and CI/CD.

## Generating protos

Run `./proto/gen.sh` to generate proto code for all languages. Languages are
specified by a gen_\<language\>.sh script and a separate Dockerfile. Run the
individual script to generate proto code for a single language.

## CI/CD

The example CI/CD workflows include one that generates proto code for all
languages and diffs them to ensure that PRs that change proto files also update
the generated proto code.
