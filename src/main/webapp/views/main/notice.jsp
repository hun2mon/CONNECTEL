<!DOCTYPE html>
<html>
<head>
    <title>WebSocket Notification</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>
        var stompClient = null;

        function connect() {
            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
                stompClient.subscribe('/user/queue/notifications', function (notification) {
                    showNotification(JSON.parse(notification.body));
                });
            });
        }

        function showNotification(notification) {
            var notificationElement = document.createElement('div');
            notificationElement.appendChild(document.createTextNode("Notification: " + notification.content));
            document.getElementById('notifications').appendChild(notificationElement);
        }

        window.onload = connect;
    </script>
</head>
<body>
    <div id="notifications"></div>
</body>
</html>