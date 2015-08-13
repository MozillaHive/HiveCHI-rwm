# Ansible managed: /Users/derekgilwa/Documents/Thoughtworks/AC_PROGRAM/side_projects/HiveCHI-rwm/railsbox/ansible/roles/unicorn/templates/unicorn.rb.j2 modified on 2015-08-12 21:53:12 by derekgilwa on DerekGliwa.local

working_directory '/HiveCHI-rwm'

pid '/HiveCHI-rwm/tmp/unicorn.development.pid'

stderr_path '/HiveCHI-rwm/log/unicorn.err.log'
stdout_path '/HiveCHI-rwm/log/unicorn.log'

listen '/tmp/unicorn.development.sock'

worker_processes 2

timeout 30
