#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#!!
#! @description: Pulls and runs a Docker container in a Swarm cluster.
#! @input swarm_manager_ip: IP address of the machine with the Swarm manager container
#! @input swarm_manager_port: port used by the Swarm manager container
#! @input container_name: optional - container name
#! @input container_params: optional - command parameters
#! @input container_command: optional - container command
#! @input image_name: Docker image that will be assigned to the container
#! @input host: Docker machine host
#! @input port: optional - SSH port
#! @input username: Docker machine username
#! @input password: optional - Docker machine password
#! @input private_key_file: optional - path to private key file
#! @input character_set: optional - character encoding used for input stream encoding from target machine
#!                       Valid: SJIS, EUC-JP, UTF-8
#! @input pty: optional - whether to use PTY - Valid: true, false
#! @input timeout: optional - time in milliseconds to wait for the command to complete
#! @input close_session: optional - if false SSH session will be cached for future calls during the life of the flow,
#!                       if true the SSH session used will be closed;
#!                       Valid: true, false
#! @input agent_forwarding: optional - whether to forward the user authentication agent
#! @output container_id: ID of the container
#! @result SUCCESS: successful
#! @result FAILURE: otherwise
#!!#
####################################################

namespace: io.cloudslang.docker.swarm

imports:
  containers: io.cloudslang.docker.containers

flow:
  name: run_container_in_cluster
  inputs:
    - swarm_manager_ip
    - swarm_manager_port
    - container_name:
        required: false
    - container_params:
        required: false
    - container_command:
        required: false
    - image_name
    - host
    - port:
        required: false
    - username
    - password:
        required: false
    - private_key_file:
        required: false
    - character_set:
        required: false
    - pty:
        required: false
    - timeout:
        required: false
    - close_session:
        required: false
    - agent_forwarding:
        required: false
    - docker_options:
        default: ${'-H tcp://' + swarm_manager_ip + ':' + swarm_manager_port}
        private: true

  workflow:
    - run_container_in_cluster:
        do:
          containers.run_container:
            - docker_options
            - container_name
            - container_params
            - container_command
            - image_name
            - host
            - port
            - username
            - password
            - private_key_file
            - character_set
            - pty
            - timeout
            - close_session
            - agent_forwarding
        publish:
          - container_id
  outputs:
    - container_id
