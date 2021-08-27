import unittest

from my_package import my_module


class TestMyModule(unittest.TestCase):
    def test_my_function(self):
        self.assertEqual(my_module.my_function(1, 2), 3)
