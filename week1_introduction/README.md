# SDSC HPC User Training 2021
* Updated 1/21/21 by Mary Thomas

## WEEK 1: Jan 22, 2021

## TOPIC:  Kickoff and Orientation
**Presented By:** [Mary Thomas, SDSC](https://hpc-students.sdsc.edu/instr_bios/mary_thomas.html) (mpthomas at ucsd.edu)

## READING AND PRESENTATIONS:
* [HPC User Training - Overview - Jan 22, 2021](./hpc-user-training-overview-jan-22-2021.pdf)
* [HPC-Overview.pdf](./hpc-overview.pdf)

## WEEK 1 TASKS:
1. Register for the HPC Training:
[https://na.eventscloud.com/website/21055/home/](https://na.eventscloud.com/website/21055/home/)


2. Setup XSEDE Portal Account:
* [https://portal.xsede.org](http://portal.xsede.org)
* Get portalID

3. Confirm Enrollment and submit your PortalID (Google Form):
* [https://tinyurl.com/hpc-user-training-signup](https://tinyurl.com/hpc-user-training-signup)
* Be sure to enter your XSEDE PortalID

4. Once you have confirmed your enrollment and given us your XSEDE PortalID:
* You will be added to the HPC Training Education Allocation.
* In a few days, you will recieve notification that your Expanse account is ready for logging on with instructions on how to set your password.
* **Note: Your Expanse account password will be the same password that you used when creating your XSEDE Portal account.**

5. After your account has been created on Expanse and you have set your password, log on and clone the training repository:
`
[mthomas@login01 ~]$ git clone https://github.com/sdsc-hpc-training-org/hpc-training-2021.git
Cloning into 'hpc-training-2021'...
remote: Enumerating objects: 23, done.
remote: Counting objects: 100% (23/23), done.
remote: Compressing objects: 100% (17/17), done.
remote: Total 23 (delta 8), reused 5 (delta 2), pack-reused 0
Unpacking objects: 100% (23/23), done.
[mthomas@login01 ~]$ cd hpc-training-2021/
`
`
[mthomas@login01 hpc-training-2021]$ ll
total 80
drwxr-xr-x  4 mthomas use300     7 Jan 22 02:43 .
drwxr-x--- 23 mthomas use300    42 Jan 22 02:43 ..
drwxr-xr-x  8 mthomas use300    13 Jan 22 02:43 .git
-rw-r--r--  1 mthomas use300  1799 Jan 22 02:43 .gitignore
-rw-r--r--  1 mthomas use300 18092 Jan 22 02:43 LICENSE
-rw-r--r--  1 mthomas use300    96 Jan 22 02:43 README.md
drwxr-xr-x  2 mthomas use300     3 Jan 22 02:43 week1_introduction
[mthomas@login01 hpc-training-2021]$ cd week1_introduction/
`
`
[mthomas@login01 week1_introduction]$ ll
total 27
drwxr-xr-x 2 mthomas use300    3 Jan 22 02:43 .
drwxr-xr-x 4 mthomas use300    7 Jan 22 02:43 ..
-rw-r--r-- 1 mthomas use300 2522 Jan 22 02:43 README.md
[mthomas@login01 week1_introduction]$ 
`

6. run a few of the commands in these basic self-guided tutorials (to make sure the account is working):
* [Basic_HPC skills:](https://github.com/sdsc-hpc-training-org/basic_skills)
* Check that your Unix skills and connection skills are good.

6. Suggestion:  Make it easier and more secure to connect to Expanse using ssh-agent:   
* https://github.com/sdsc-hpc-training-org/hpc-security/blob/master/ssh_methods/connect-using-ssh-agent.md
Note: we do not recommend using passwordless SSH.

## REPORTING YOUR WORK:
We will track your work using automated scripts, so you need to name the directories as described below:

1. Create a directory under your Comet home account, and call it "hpct21" (for HPC Training)
2. Create a subdirectory called week1. If you want to add more information to the name, you can
use the convention `week1_introduction`,  `week1_description` or `week1_date` etc.
* This should result in a directory called 
*	/home/#username/hpct21/week1

