import asyncio

# those imports i found to be implicit so make sure they really work

import plistlib

# for exec_module
import importlib.util

# from setuptools
from pkg_resources import resource_filename


import hpy
print('expect trouble right here without patch')
import hpy.universal

print(hpy.universal)

# if patched should go there

import hpytest

print(f"""
    {hpy=}
    {hpy.universal=}
    {hpytest=}



running function {hpytest.say_hello=} :

""")

print( hpytest.say_hello() )

