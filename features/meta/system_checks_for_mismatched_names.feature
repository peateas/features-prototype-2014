Feature:  System checks for mismatched names
  As a design team member
  I want the system to check feature names
  So that mistakes are caught and prevented

Scenario:
  Given this cucumber directory
  When the system checks names
  Then all the names match the file names
