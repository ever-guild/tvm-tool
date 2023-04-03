#!/usr/bin/env bash

toc="${1}"
if [ -z "${toc}" ]; then
    echo "Usage: $(basename "${0}") <toc>"
    exit 1
fi

tvm_linker disasm text --raw "${toc}" > "${toc}.disasm"
