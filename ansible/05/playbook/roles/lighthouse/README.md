Role Name
=========

This role can install Lighthouse

Requirements
------------

```bash
pre_tasks:
    - name: Install depends
      become: true
      ansible.builtin.yum:
        name:
          - git
        state: present
```

Role Variables
--------------

| Vars | Description |
| lighthouse_dest_dir | Directory lighthouse for nginx |

Dependencies
------------

- git
- nginx

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```bash
    - hosts: servers
      roles:
         - { role: lighthouse }
```

License
-------

MIT

Author Information
------------------

Aleksandr Bugrov
