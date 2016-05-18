<html>
<head>
<title>Active Job Dashboard</title>
<script>
setTimeout(function() {
    window.location.reload(true);
}
, 10000);
</script>
</head>
<body>
<table>
% for row in rows:
	% include('row', values=row, header=False)
% end
</table>
</body>
</html>