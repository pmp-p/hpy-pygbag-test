#!/bin/bash
WD=$(pwd)
[ -d hpy ] || git clone https://github.com/pmp-p/hpy-pygbag hpy


# need install to get the egg
pushd hpy
/opt/python-wasm-sdk/python3-wasm setup.py install
popd


pushd hpytest-module
export PYTHONPATH=$(echo -n ${WD}/hpy/build/lib.wasm32-*-emscripten-cpython-311)

/opt/python-wasm-sdk/python3-wasm setup.py build

popd

rm  -rf hpy-pygbag/hpy hpy-pygbag/*so hpy-pygbag/*map

mv -v hpy/build/lib.wasm32-*-emscripten-cpython-311/hpy hpytest-module/build/lib.wasm32-*-emscripten-cpython-311/*  hpy-pygbag/


( sleep 3 && xdg-open "http://localhost:8000?-i" )&

pygbag --ume_block 0 --template noctx.tmpl --cdn https://pygame-web.github.io/showroom/dev/ hpy-pygbag/main.py
