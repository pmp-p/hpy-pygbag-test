import sys
from setuptools import setup, Extension
from os import path, environ

DIR = path.dirname(__file__)

setup(
    name="hpytest",
    hpy_ext_modules=[
        Extension('hpytest', sources=[path.join(DIR, 'sayhello.c')],
            extra_compile_args=[
                "-fPIC",
            ],
            extra_link_args = ['-shared'],
        ),
    ],
    setup_requires=['hpy'],
)


