import unittest
import subprocess

class TestAssignment(unittest.TestCase):

    def test_question_01(self):
        command = ['python3', 'test/test-question.py', '-c', 'q01.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_02(self):
        command = ['python3', 'test/test-question.py', '-c', 'q02.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_03(self):
        command = ['python3', 'test/test-question.py', '-c', 'q03.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_04(self):
        command = ['python3', 'test/test-question.py', '-c', 'q04.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_05(self):
        command = ['python3', 'test/test-question.py', '-c', 'q05.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_06(self):
        command = ['python3', 'test/test-question.py', '-c', 'q06.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_07(self):
        command = ['python3', 'test/test-question.py', '-c', 'q07.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

    def test_question_08(self):
        command = ['python3', 'test/test-question.py', '-c', 'q08.py']
        result = subprocess.run(command)
        self.assertEqual(result.returncode, 0)

if __name__ == '__main__':
    unittest.main()
