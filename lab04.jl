## BEE 4750 Lab 4: Scenario Trees and Sequential Decisions
##
## Plain-script version of lab04.ipynb, for anyone who prefers working in a
## script rather than a notebook. See lab04.qmd / lab04.ipynb for the full
## problem statements, and activity-sheet.pdf for the written parts.
##
## Run this top to bottom in the Julia REPL (e.g. `include("lab04.jl")`) or
## a cell-by-cell VS Code session.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

## --- The reservoir -----------------------------------------------------
##
## A water-supply reservoir serves a city and an irrigation district from
## June to September. It holds up to 8 units and is full on June 1.
##
## Each month: choose a release r (whole units, at most what is stored and
## at most the demand of 4) before knowing the month's inflow; then the
## inflow arrives, and anything above capacity spills:
##
##     next month's storage = min(s - r + inflow, capacity)
##
## Each month is dry or wet. With no forecast, a month is dry with
## probability 0.5, independently of the other months. Water left on
## October 1 is worth carryover_value per unit (0 by default).
##
## The standard operating policy releases min(storage, 4) every month.
##
## The code below stores these values and defines two functions that the
## rest of the lab uses: benefit(r) looks up the benefit of releasing r
## units in a month, and next_storage(s, r, inflow) gives next month's
## storage from this month's storage s, release r, and inflow.

# Storage and flows are in units of 1 million cubic meters, and
# benefits in $100,000
capacity = 8                          # storage capacity
start_storage = 8                     # storage on June 1 (full)
max_release = 4                       # demand: most usable in a month
benefit_table = [0, 10, 17, 20, 21]   # benefit of releasing 0 to 4
months = ["June", "July", "August", "September"]
n_months = length(months)
inflow_dry = [0, 0, 0, 0]             # dry-month inflow, June to Sept.
inflow_wet = [4, 4, 2, 2]             # wet-month inflow, June to Sept.

# Benefit of releasing r units in a month (releasing 0 is the first
# entry of the table)
benefit(r) = benefit_table[r + 1]

# Storage at the start of next month: release r from storage s, then
# the month's inflow arrives; anything above capacity spills
next_storage(s, r, inflow) = min(s - r + inflow, capacity)

## --- Problem 1: The Scenario Tree --------------------------------------
##
## Before writing code, complete Problem 1 on the Activity Sheet.

## --- Problem 2: Dynamic Programming ------------------------------------
##
## Start with Problem 2a on the Activity Sheet: write down the Bellman
## equation for this reservoir. Then implement it below.
##
## value_table holds V_t(s), and policy_table the release that achieves
## it. Storage s is kept in row s + 1 of each table, because Julia arrays
## start at 1. Month t (1 for June to 4 for September) is in column t, and
## column 5 of value_table holds the terminal value V_5(s). Each of the
## four TODOs is one part of your Bellman equation: replace each `missing`
## with the code for that part.

function backward_induction(prob_dry, carryover_value)
    # best expected total from month t on, and the release that gets it
    value_table = zeros(capacity + 1, n_months + 1)
    policy_table = zeros(Int, capacity + 1, n_months)
    for s in 0:capacity
        # TODO: replace `missing` with the value of s units of water
        # left on October 1
        value_table[s + 1, n_months + 1] = missing
    end
    for t in n_months:-1:1
        for s in 0:capacity
            best_total = -Inf
            # TODO: replace `missing` with the largest release allowed
            # from storage s
            for r in 0:missing
                # TODO: replace each `missing` with next month's storage
                # after a dry month and after a wet month
                storage_if_dry = missing
                storage_if_wet = missing
                # TODO: replace `missing` with this month's benefit plus
                # the expected value_table entry at next month's storage
                total = missing
                # keep the best release (ties keep the smaller one)
                if total > best_total
                    best_total = total
                    value_table[s + 1, t] = total
                    policy_table[s + 1, t] = r
                end
            end
        end
    end
    return value_table, policy_table
end

# No forecast (prob_dry = 0.5) and no value on leftover water
value_table, policy_table = backward_induction(0.5, 0)
println("Expected total benefit: ", value_table[start_storage + 1, 1])
println("June release: ", policy_table[start_storage + 1, 1])

# The whole policy: the best release for each storage level and month
println("Storage: releases in June, July, August, September")
for s in 0:capacity
    println(s, ": ", policy_table[s + 1, :])
end

# Follows a policy through one sequence of inflows and returns the
# releases and the storage left on October 1. Complete the two TODOs.
function follow_policy(policy_table, inflows)
    releases = zeros(Int, n_months)
    storage = start_storage
    for t in 1:n_months
        # TODO: replace `missing` with the policy's release in month t
        # from this storage
        releases[t] = missing
        # TODO: replace `missing` with the storage at the start of
        # next month
        storage = missing
    end
    return releases, storage
end

driest_releases, driest_storage_left =
    follow_policy(policy_table, inflow_dry)
wettest_releases, wettest_storage_left =
    follow_policy(policy_table, inflow_wet)
println("Driest summer: ", driest_releases)
println("Wettest summer: ", wettest_releases)

## Record these, the expected total benefit, and June's release in Table 1
## on the Activity Sheet.

## --- Problem 3 (Optional): Extensions of the Basic DP Model -------------
##
## If you finish Problems 1 and 2, start with Problem 3a on the Activity
## Sheet (follow the standard operating policy by hand and compare it with
## Problem 2's policy). For Problem 3b, re-solve with backward_induction
## and follow_policy for each case in Table 2.

outlook_prob_dry = [0.2, 0.8, 0.5, 0.5]
carryover_values = [0, 0, 4, 8]
for i in 1:length(outlook_prob_dry)
    # TODO: solve the case with outlook_prob_dry[i] and
    # carryover_values[i], then print June's release, the expected
    # total value, and the releases in the driest and wettest summers
end

## Record your results in Table 2, then answer Problem 3c on the Activity
## Sheet.
