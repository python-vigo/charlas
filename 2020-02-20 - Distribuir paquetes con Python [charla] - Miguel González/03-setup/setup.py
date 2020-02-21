import setuptools

setuptools.setup(
    name="chove",
    version="0.0.2",
    author="Miguel González",
    author_email="migonzalvar@gmail.com",
    description="Check if it's rainning.",
    long_description="It uses Meteogalicia.",
    url="https://github.com/migonzalvar/chove",
    py_modules=["chove"],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.6",
)
