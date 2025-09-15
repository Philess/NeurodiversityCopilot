import os

def main():
    my_input = os.environ.get('INPUT_MY-INPUT', 'default value')
    print(f"Hello from Python! You gave input: {my_input}")

if __name__ == "__main__":
    main()