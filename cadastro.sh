CADASTRO_FILE="cadastro.txt"

while IFS=' ' read -r username password group; do
    if ! getent group "$group" > /dev/null 2>&1; then
        echo "Criando grupo: $group"
        groupadd "$group"
    fi

    if ! id -u "$username" > /dev/null 2>&1; then
        echo "Criando usuário: $username"
        useradd -m -g "$group" -p "$(openssl passwd -1 "$password")" "$username"
    else
        echo "Usuário $username já existe, pulando..."
    fi
done < "$CADASTRO_FILE"