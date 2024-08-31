#!/bin/bash

echo "Release ElixirLS"
cd language-server/elixir
echo "Running 'mix deps.get'..."
mix deps.get
echo "Running 'MIX_ENV=prod mix compile'..."
MIX_ENV=prod mix compile
echo "Running 'MIX_ENV=prod mix elixir_ls.release2'..."
MIX_ENV=prod mix elixir_ls.release2

echo "All tasks completed!"
