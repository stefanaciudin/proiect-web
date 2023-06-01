<?php
include_once 'User.php';
include_once 'bd.php';

class UserRepository
{
    public static function save(User $user): bool
    {
        global $conn;
        $stmt = $conn->prepare("INSERT INTO users (name, surname, username, email, password) VALUES (?, ?, ?, ?, ?)");
        $name = $user->getName();
        $surname = $user->getSurname();
        $username = $user->getUsername();
        $email = $user->getEmail();
        $password = $user->getPassword();
        $stmt->bind_param("sssss", $name, $surname, $username, $email, $password);
        if ($stmt->execute()) {
            // user saved successfully
            return true;
        } else {
            return false;
        }
    }

    public static function update(User $user, int $userId): bool
    {
        global $conn;
        $stmt = $conn->prepare("UPDATE users SET age = ?, gender = ?, skintype_id = ?, location = ? WHERE user_id = ?");
        $age = $user->getAge();
        $gender = $user->getGender();
        $skin_type = $user->getSkinType();
        $location = $user->getLocation();
        $stmt->bind_param("isisi", $age, $gender, $skin_type, $location, $userId);
        if ($stmt->execute()) {
            error_log("User updated successfully");
            return true;
        } else {
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
        return $row['max_id'];
    }

    public static function findByUsername($username): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        return self::findUser($stmt);
    }

    public static function findUserById($id): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $id);
        return self::findUser($stmt);
    }

    public static function findByEmail($email): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        return self::findUser($stmt);
    }

    public static function getAllUsers(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users");
        return self::executeAndFetchUsers($stmt);
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
                $row["password"]
            );
            $user->setUserId($row["user_id"]);
            $users[] = $user;
        }
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
            $row["password"]
        );
        $user->setUserId($row["user_id"]);
        $user->setAge(self::mapAgeFromDatabase($row['age']));
        $user->setGender(self::mapGenderFromDatabase($row['gender']));
        $user->setSkinType(self::mapSkinTypeFromDatabase($row['skintype_id']));
        $user->setLocation($row['location']);
        return $user;
    }

    public static function deleteUser(int $userId): bool
    {
        global $conn;
        $stmt = $conn->prepare("DELETE FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $userId);

        if ($stmt->execute()) {
            // user deleted successfully
            return true;
        } else {
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
}
