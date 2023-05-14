<?php
include_once 'bd.php';

class User
{
    private mixed $user_id;
    private mixed $name;
    private mixed $surname;
    private mixed $username;
    private mixed $email;
    private mixed $password;

    public function __construct($name, $surname, $username, $email, $password)
    {
        $this->name = $name;
        $this->username = $username;
        $this->surname = $surname;
        $this->email = $email;
        $this->password = $password;
    }

    /**
     * @return mixed
     */
    public function getUserId(): mixed
    {
        return $this->user_id;
    }

    /**
     * @param mixed $user_id
     */
    public function setUserId(mixed $user_id): void
    {
        $this->user_id = $user_id;
    }

    /**
     * @return mixed
     */
    public function getName(): mixed
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     */
    public function setName(mixed $name): void
    {
        $this->name = $name;
    }

    /**
     * @return mixed
     */
    public function getSurname(): mixed
    {
        return $this->surname;
    }

    /**
     * @param mixed $surname
     */
    public function setSurname(mixed $surname): void
    {
        $this->surname = $surname;
    }

    /**
     * @return mixed
     */
    public function getUsername(): mixed
    {
        return $this->username;
    }

    /**
     * @param mixed $username
     */
    public function setUsername(mixed $username): void
    {
        $this->username = $username;
    }

    /**
     * @return mixed
     */
    public function getEmail(): mixed
    {
        return $this->email;
    }

    /**
     * @param mixed $email
     */
    public function setEmail(mixed $email): void
    {
        $this->email = $email;
    }

    /**
     * @return mixed
     */
    public function getPassword(): mixed
    {
        return $this->password;
    }

    /**
     * @param mixed $password
     */
    public function setPassword(mixed $password): void
    {
        $this->password = $password;
    }

    public function save(): bool
    {
        global $conn;
        $stmt = $conn->prepare("INSERT INTO users (name, surname, username, email, password) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $this->name, $this->surname, $this->username, $this->email, $this->password);
        if ($stmt->execute()) {
            // user saved successfully
            return true;
        } else {
            return false;
        }
    }

    public static function findUser(bool|mysqli_stmt $stmt): ?User
    {
        $stmt->execute();
        $result = $stmt->get_result();
        // check if a user was found
        if ($result->num_rows == 0) {
            return null;
        }
        $row = $result->fetch_assoc();
        $user = new User(
            $row["name"],
            $row["surname"],
            $row["username"],
            $row["email"],
            $row["password"]
        );
        $user->user_id = $row["user_id"];
        return $user;
    }

    public static function getUser(bool|mysqli_stmt $stmt, $username): ?User
    {
        $stmt->bind_param("s", $username);
        return self::findUser($stmt);
    }

    public static function findByUsername($username): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
        return self::getUser($stmt, $username);
    }
    public static function findUsernameById($id):?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT username FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $id);
        return self::findUser($stmt);
    }
    public static function findByEmail($email): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
        return self::getUser($stmt, $email);
    }
}
