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


if [ -f /pp ]
then

    PYTHONPATH=/data/git/pygbag \
     py -m pygbag --ume_block 0 --dev --git --template noctx.tmpl /data/git/pygbag/src/hpy/hpy-pygbag-test/hpy-pygbag/main.py

else

    ( sleep 3 && xdg-open "http://localhost:8000?-i" )&

    pygbag --ume_block 0 --template noctx.tmpl --git hpy-pygbag/main.py

fi
