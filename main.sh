PORTS=(59101 59102 59103)

check_tunnel() {
  ss -tunlp | grep ":$1" > /dev/null
  return $?
}

for PORT in "${PORTS[@]}"; do
  if check_tunnel $PORT; then
    echo "Port $PORT is running successfully"
  else
    echo "Trying to reconnect on port $PORT"
    ssh -fNL 0.0.0.0:$PORT:$SERVER_IP:SERVER_PORT  127.0.0.1
  fi
done
