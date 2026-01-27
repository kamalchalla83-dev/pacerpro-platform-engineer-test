# PacerPro Platform Engineer Coding Test

## Overview
This project implements an automated remediation pipeline to detect slow API responses
and automatically recover infrastructure to reduce MTTR.

## Architecture
Sumo Logic → AWS Lambda → EC2 → SNS

## Components
- Sumo Logic log query and alert
- AWS Lambda for remediation
- EC2 instance restart
- SNS notification
- Terraform-based IaC

## Assumptions
- Logs contain response_time in milliseconds
- Single EC2 instance for simplicity

## Security
- Least-privilege IAM
- No secrets committed

## Improvements
- Cooldown timers
- Health checks
- Canary remediation


