FROM ocaml/opam:debian-13-opam

WORKDIR /app

RUN opam init --disable-sandboxing -y
RUN eval $(opam env)
RUN opam switch create my_project 5.4.0 -y
RUN eval $(opam env)
RUN opam install ocaml-lsp-server odoc ocamlformat utop -y
RUN eval $(opam env)

COPY . .

