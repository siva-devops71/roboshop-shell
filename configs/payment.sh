[Unit]
Description=Payment Service

[Service]
User=root
WorkingDirectory=/app
Environment=CART_HOST=cart.devops71.online
Environment=CART_PORT=8080
Environment=USER_HOST=user.devops71.online
Environment=USER_PORT=8080
Environment=AMQP_HOST=rabbitmq.devops71.online
Environment=AMQP_USER=roboshop
Environment=AMQP_PASS=ROBOSHOP_USER_PASSWORD

ExecStart=/usr/local/bin/uwsgi --ini payment.ini
ExecStop=/bin/kill -9 $MAINPID
SyslogIdentifier=payment

[Install]
WantedBy=multi-user.target