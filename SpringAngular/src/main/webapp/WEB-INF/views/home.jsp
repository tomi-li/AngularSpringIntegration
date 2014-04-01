<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html ng-app="userTest">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap 101 Template</title>

<!-- Bootstrap -->
<link href="<spring:url value="resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<spring:url value="resources/js/sockjs.js" />"></script>
<script src="<spring:url value="resources/js/stomp.js" />"></script>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<div ng-controller="userCtrl">
		<input ng-model="user.username" /> <input ng-model="user.password" />
		<button ng-click="addUser()">add user</button>

		<table class="table table-strip">
			<tr ng-repeat="user in users">
				<td>{{ user.username }}</td>
				<td><button ng-click="deleteUser(user.username)"
						class="btn btn-default">
						<i class="glyphicon glyphicon-remove"></i>
					</button></td>
			</tr>
		</table>
	</div>
	
	<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
    </div>
    <div id="conversationDiv">
        <label>What is your name?</label><input type="text" id="name" />
        <button id="sendName" onclick="sendName();">Send</button>
        <p id="response"></p>
    </div>
</div>
	

	
	<button onclick="sendName"> sendName </button>
	

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<spring:url value="resources/js/bootstrap.min.js" />"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.2/angular.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.2/angular-route.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.2/angular-resource.min.js"></script>

	<script type="text/javascript">
		angular.module('userTest', [ 'ngResource' ]);

		function userCtrl($scope, $resource) {
			var url = "http://localhost:8080/test/";
			var User = $resource(url + "user/:id", {
				id : '@id'
			});

			$scope.addUser = function() {
				// $scope.users.push({username : $scope.userName});
				User.save($scope.user, function() {
					$scope.sync();
				});
			};
			$scope.deleteUser = function(username) {
				User.remove({
					id : username
				}, function() {
					$scope.sync();
				});
			};

			$scope.sync = function() {
				$scope.users = User.query();
			};

			$scope.sync();
		}
	</script>
	
	<script type="text/javascript">
	// Create stomp client over sockJS protocol (see Note 1)
	 var socket = new SockJS("<spring:url value="/hello"/>");
	 var stompClient = Stomp.over(socket);

	 // callback function to be called when stomp client is connected to server (see Note 2)
	 var connectCallback = function() {
	      alert("connected!");
	      stompClient.subscribe('/topic/greetings', function(greeting){
	           alert(JSON.parse(greeting.body).content);
	      });
	 }; 

	 // callback function to be called when stomp client could not connect to server (see Note 3)
	 var errorCallback = function(error) {
	      // display the error's message header:
	      alert(error.headers.message);
	 };

	 // Connect as guest (Note 4)
	 stompClient.connect("guest", "guest", connectCallback, errorCallback);
</script>
</body>
</html>