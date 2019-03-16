# pgconf2019
Code and Presentation Materials for Postgres Conference 2019

# Infrastructure #

All of the tooling and testing is setup to be as automated and reproducible
as reasonable.

Infrastructure is created using _terraform_ and the `tooling/` folder
contains the shell scripts used to run the tests.

The terraform code is divided into test _scenarios_.

# Using the tooling #

## Assumptions ##
These directions assume you are familiar with _terraform_, have `terraform` 0.11.x
installed and in your `PATH` and are on a Unix-like OS.

## Setup and Operation ##

1. The tooling has different test scenarios, each within the `terraform/` directory.
2. You need to create a few things in the `terraform/` directory:
    1. A `setup_env.sh` with appropriate cloud provider credentials for your accounts.
        Follow the `setup_env_example.sh`. This is dotted into your shell.
    2. An ssh key pair with a non-password protected private key.
3. Select a scenario (e.x. `aws-rds-1`, see each folder for scenario details) and
    `cd` its directory.
4. Run `terraform init` from the scenario folder.
5. Run `terraform plan` from the scenario folder.
6. If you feel the plan is correct, run `terraform apply`.
7. Upon completion the IP address of a working VM will be displayed
    - For VM based tests, this is the machine on which you will run PG server and client.
    - For hosted PG based tests (i.e. RDS, etc), this is the machine that runs the test client
    and is in the same virtual network as your hosted instance.
8. You can ssh to this VM and in the `/data/tooling` folder under the default
    username (e.g. `ubuntu` on AWS), you will find shell scripts that
    run the tests.
9. When finished, run `terraform destroy` to clean up.

# Legal, Thanks and Other Disclaimers #

## Legal ##

- License: See `LICENSE` file with this repository/archive/distribution.
- NO WARRANTY at all. No guarantees of security.
    - This is TEST CODE.
    - Do not run your cloud operations based on this code.

## Disclaimers, Caveats ##

- No affiliation: I do not have any formal business relationship with any of the cloud
providers tested (except in certain circumstances perhaps as a minor customer).
- All physical metal computers tested are owned exclusively by me.
- Cloud resources sponsored by Mehboob Alam c/o PG Conference 2019

## Thanks ##
- This work and presentation made possible by PG Conference 2019.
- MedAcuity Software for the time off to attend the conference.

