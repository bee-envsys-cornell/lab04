# Lab 4: Scenario Trees and Sequential Decisions

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is the repository for Lab 4 for [BEE 4750](https://viveks.me/environmental-systems-analysis), taught at [Cornell University](https://cornell.edu) in Fall 2026 by [Vivek Srikrishnan](https://viveks.me).

If enrolled in the class, your completed Activity Sheet should be submitted to Gradescope as a PDF, or handed in on paper at the end of class, by the due date listed in the assignment (see `lab04.qmd`/`lab04.ipynb`); you don't need to submit your code. 10% will be deducted for each day the submission is late.

## Learning Objectives

After completing this lab, students will be able to:

- write down the transition function of a multi-month reservoir operation problem;
- sketch the scenario tree for its first months, with the probability of each branch and node;
- write down the Bellman equation for the problem under uncertain inflows, implement it by backward induction, and follow the resulting policy through a given sequence of inflows;
- (optional) compare that policy with the standard operating policy, and describe how the value of water left at the end of the season changes June's release.

## Repository Overview

The repository consists of the following files:

- `lab04.ipynb`: Jupyter Notebook version of the assignment. Students who prefer notebooks should create code or Markdown blocks as necessary to answer questions.
- `lab04.jl`: plain Julia script version of the same coding problems, for students who prefer working in a script instead of a notebook. Same problems and structure as the notebook.
- `Project.toml`, `Manifest.toml`: Julia environment files. These should just work, but feel free to add other packages as needed using the `Pkg` package manager.
- `lab04.qmd`: Source file for notebook generation. You shouldn't need to touch this.
- `activity-sheet.qmd`: Source file for the Activity Sheet PDF. You shouldn't need to touch this. I will hand out the PDFs in class.
- `LICENSE`: This material is licensed using the MIT license. You can ignore this for working on the problem set.
- `README.md`: This file. You shouldn't need to touch this.
- `.gitignore`: This tells `git` what files to ignore. You shouldn't need to touch this.

## Dependencies

This lab uses only Julia's standard library; `IJulia` is in the environment so the notebook runs in Jupyter.

## Prerequisites

1. [Install Julia](https://julialang.org/downloads/) before beginning this lab. This notebook was developed with version 1.11.5, but any 1.11.x should work (there could be some issues with other versions, depending on what's changed).
2. If necessary, [install git](https://happygitwithr.com/install-git.html) and [create a GitHub account](https://github.com).
