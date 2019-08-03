
So you need to open filesystem using Windows+E

The repositorie is located in OneDrive/mgf-mechanisms

Then you need to open git for this:
- use right click over blank space
- and click on git bash

This will open a bash terminal



For adding the change you've made, you will need to use the command:

git add .

and to save those change in the git tree you will need to use the command:

git commit -m "the message that explain what you done"

for know if your commit is in the tree type following command:

git log


finally you push your change to the repo online
so you need to type the following command:

git push origin master

origin = remote name
master = branch name


for retrieve change from the online repository you to type:

git pull origin master --rebase


## Tips 1: For cloning the repo from github

type the following command:

git clone https://github.com/gpgi-financing/mgf-mechanisms.git


## Tips 2: For changing the name of a file use: 

git mv parameters.m main.m


## Tips 3: Guideline for syntax style

https://www.python.org/dev/peps/pep-0008/#indentation

Ex:

maximal_number_of_rounds_without_any_player_joining = 24;
