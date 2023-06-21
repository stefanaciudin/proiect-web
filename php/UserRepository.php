<?php
include_once 'User.php';
include_once 'bd.php';

class UserRepository
{
    public static function save(User $user): bool
    {
        global $conn;
        $stmt = $conn->prepare("INSERT INTO users (name, surname, username, email, password, token) VALUES (?, ?, ?, ?, ?, ?)");
        $name = $user->getName();
        $surname = $user->getSurname();
        $username = $user->getUsername();
        $email = $user->getEmail();
        $password = $user->getPassword();
        $token = $user->getToken();
        $stmt->bind_param("ssssss", $name, $surname, $username, $email, $password, $token);
        if ($stmt->execute()) {
            // user saved successfully
            $stmt->close();
            return true;
        } else {
            $stmt->close();
            return false;
        }
    }

    public static function update(int $userId): bool
    {
        global $conn;
        $age = $_POST['age'];
        $gender = $_POST['gender'];
        $location = $_POST['location'];
        $skin_type = $_POST['skin_type'];
        if($skin_type == 'gras'){
            $id_skin = 1;
        }else if($skin_type == 'normal'){
            $id_skin = 2;
        }else if($skin_type == 'mixt')
        {
            $id_skin = 3;
        }else if($skin_type == 'uscat'){
            $id_skin = 4;
        }
        $stmt = $conn->prepare("UPDATE users SET age = ?, gender = ?, skintype_id = ?, location = ? WHERE user_id = ?");
        $stmt->bind_param("isisi", $age, $gender, $id_skin, $location, $userId);
        if ($stmt->execute()) {
            error_log("User updated successfully");
            $stmt->close();
            return true;
        } else {
            error_log("User updated error");
            $stmt->close();
            return false;
        }
    }

    public static function returnMaxId(): int
    {
        global $conn;
        $stmt = $conn->prepare("SELECT MAX(user_id) as max_id from users");
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();
        return $row['max_id'];
    }

    public static function findByUsername($username): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        return static::findUser($stmt);
    }

    public static function findUserById($id): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT user_id, name, surname, username, email, password, age, skintype_id, gender, location FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $stmt->bind_result($user_id, $name, $surname, $username, $email, $password, $age, $skintype_id, $gender, $location);
        while ($stmt->fetch()) {
            $user = array(
                'id' => $user_id,
                'name' => $name,
                'surname' => $surname,
                'username' => $username,
                'email' => $email,
                'password' => $password,
                'age' => $age,
                'skintype_id' => $skintype_id,
                'gender' => $gender,
                'location' => $location
            );
        }
        $stmt->close();
        return $user;


    }

    public static function findByEmail($email): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        return static::findUser($stmt);
    }

    public static function getAllUsers(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users");
        return static::executeAndFetchUsers($stmt);
    }

    private static function executeAndFetchUsers(mysqli_stmt $stmt): array
    {
        $stmt->execute();
        $result = $stmt->get_result();
        $users = array();
        while ($row = $result->fetch_assoc()) {
            $user = new User(
                $row["name"],
                $row["surname"],
                $row["username"],
                $row["email"],
                $row["password"],
                $row["token"]
            );
            $user->setUserId($row["user_id"]);
            $users[] = $user;
        }
        $stmt->close();
        return $users;
    }

    private static function findUser(mysqli_stmt $stmt): ?User
    {
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            return null;
        }
        $row = $result->fetch_assoc();
        $user = new User(
            $row["name"],
            $row["surname"],
            $row["username"],
            $row["email"],
            $row["password"],
            $row["token"]
        );
        $user->setUserId($row["user_id"]);
        $user->setAge(static::mapAgeFromDatabase($row['age']));
        $user->setGender(static::mapGenderFromDatabase($row['gender']));
        $user->setSkinType(static::mapSkinTypeFromDatabase($row['skintype_id']));
        $user->setLocation($row['location']);
        $stmt->close();
        return $user;
    }

    public static function deleteUser(int $userId): bool
    {
        global $conn;
        $stmt = $conn->prepare("DELETE FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $userId);

        if ($stmt->execute()) {
            $stmt->close();
            return true;
        } else {
            $stmt->close();
            return false;
        }
    }


    private static function mapAgeFromDatabase($ageFromDatabase): string
    {
        if ($ageFromDatabase === 18) {
            return '18-35';
        } elseif ($ageFromDatabase === 35) {
            return '35+';
        } else {
            return 'not-spec';
        }
    }

    public static function mapAgeToDatabase($ageFromDatabase): int
    {
        if ($ageFromDatabase === '18-35') {
            return 18;
        } elseif ($ageFromDatabase === '35+') {
            return 35;
        } else {
            return 0;
        }
    }


    private static function mapGenderFromDatabase(mixed $genderFromDatabase): string
    {
        if ($genderFromDatabase === 'm') {
            return 'masc';
        } elseif ($genderFromDatabase === 'f') {
            return 'fem';
        } else {
            return 'not-spec';
        }
    }

    private static function mapSkinTypeFromDatabase(mixed $skinTypeFromDatabase): string
    {
        return match ($skinTypeFromDatabase) {
            2 => 'normal',
            1 => 'oily',
            3 => 'combination',
            4 => 'dry',
            default => 'not-spec',
        };
    }

    public static function mapSkinTypeToDatabase(mixed $skinTypeFromDatabase): int
    {
        return match ($skinTypeFromDatabase) {
            'normal' => 2,
            'oily' => 1,
            'combination' => 3,
            'dry' => 4,
            default => 5,
        };
    }


}