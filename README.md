# alpha-language-image

This repo contains the specification of the build image used by the action runners in the alpha-language repo.

The image is hosted on GitHub's container registry for this organzation:  
https://github.com/orgs/CSU-CS-Melange/packages/container/package/alpha-language-image

Maven has issues running unit tests for the alpha-language project due to the way Eclipse creates the package directory structure.
Maven expects a very particular directory structure and does support running tests for package A that reside in package B.
This image can be used to execute the unit tests in the `alpha.model.tests` package.
This is used to enable the action runners to execute unit tests during the CI pipelines.

## Publish a new image

To build and publish the image, do the following.

1. Determine what tag number you'd like to use. Check the following link to see which ones are currently in use: https://github.com/CSU-CS-Melange/alpha-language-image/pkgs/container/alpha-language-image

2. Login to the GitHub container registry (ghcr.io) using a classic access token that has `write:packages` privileges to the CSU-CS-Melange organization:
```
echo '<github access token>' | docker login ghcr.io -u <github user name> --password-stdin
```

3. Run the script to build and push the image, specifying the tag you picked out previously.
```
git clone https://github.com/csu-cs-melange/alpha-language-image && cd alpha-language-image
./build-and-push-image.sh 1.X
```

## Use this image to run alpha-language unit tests

Do the following:

1. Run a new container:
```
docker run --rm -ti ghcr.io/csu-cs-melange/alpha-language-image bash
```

2. Inside the container, clone the alpha-language repo anywhere on the file system.
```
git clone https://github.com/csu-cs-melange/alpha-language.git
```

3. Set the environment variable `ALPHA_REPO_ROOT` to the root of the repo (i.e., `$ALPHA_REPO_ROOT/.git` should exist):
```
export ALPHA_REPO_ROOT=<directory from previous step>
```

4. Set the environment variable `TEST_PACKAGE` to the name of the package you want (i.e., `$ALPHA_REPO_ROOT/tests/$TEST_PACKAGE` should exist):
```
export TEST_PACKAGE=<test package name>
```

5. Run the script `org.junit.runner.JUnitCore CLASS [CLASS ...]` specifying the fully qualified class names containing the unit tests.
All test classes in that package should be specified, as the output file will be the same for all tests.
For example, to run the `AlphaAShowTest` and `AlphaCheckProgramTest` tests, run the following:
```
org.junit.runner.JUnitCore alpha.model.tests.AlphaAShowTest alpha.model.tests.AlphaCheckProgramTest
```
