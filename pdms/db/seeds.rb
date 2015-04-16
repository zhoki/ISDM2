# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create 3 essential roles
roleSysAdmin = Role.create name: 'System Administrator'
rolePM = Role.create name: 'Project Manager'
roleTM = Role.create name: 'Team Member'

# Create a new system administrator account
sa = User.create email: 'sysadmin@pdms.ait.asia', password: 'sysadmin', role_id: 1

# Create 4 initial processes in HR management
proc1 = PmbokProcess.create name: 'Plan Human Resource Management'
proc2 = PmbokProcess.create name: 'Acquire Project Team'
proc3 = PmbokProcess.create name: 'Develop Project Team'
proc4 = PmbokProcess.create name: 'Manage Project Team'

# Create 3 initial task statuses
status1 = TaskStatus.create name: 'In progress'
status2 = TaskStatus.create name: 'Submitted for approval'
status3 = TaskStatus.create name: 'Approved'
status4 = TaskStatus.create name: 'Revise'
status5 = TaskStatus.create name: 'Closed'
