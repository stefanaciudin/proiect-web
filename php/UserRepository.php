<?php
include_once 'User.php';
include_once 'bd.php';

class UserRepository
{
    /**
     * @param User $user - the user to be saved
     * @return bool - if the user was saved or not
     */
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

    /**
     * @param int $userId - the userId to be updated
     * @return bool - if the user was updated or not
     */
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

    /**
     * @return int - the max user id from the database
     */
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

    /**
     * @param $username - the username we search for
     * @return User|null - the User returned or null if it doesn't exist
     */
    public static function findByUsername($username): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        return static::findUser($stmt);
    }

    /**
     * @param $id - the id we are looking for
     * @return array - array with user info
     */
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

    /**
     * @param int $id - the user id we are suggesting products for
     * @param int $type_id - product type id
     * @param string $usage_type - usage type for the product
     * @return array - array of info about the products
     */
    public static function findByUsageType(int $id, int $type_id, string $usage_type): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.name, p.how_to_use, p.image_path, p.link, p.price
        FROM products AS p
                 JOIN users AS u ON (p.age = u.age OR p.age = 0) AND (p.skintype_id = u.skintype_id OR p.skintype_id=5)
                 JOIN product_types AS pt ON p.type_id = pt.type_id
        WHERE pt.type_id = ?
          AND pt.usage_time = ?
          AND u.user_id = ?
          ORDER BY RAND()
        LIMIT 3;");
        $stmt->bind_param("isi", $type_id, $usage_type, $id);
        $stmt->execute();
        $stmt->bind_result($name, $how_to_use, $image_path, $link, $price);
        $products = [];
        while ($stmt->fetch()) {
            $prod = array(
                'name' => $name,
                'how_to_use' => $how_to_use,
                'image_path' => $image_path,
                'link' => $link,
                'price' => $price
            );
            $products[] = $prod;
        }
        $stmt->close();
        return $products;


    }

    /**
     * @param $email - the email we are looking for
     * @return User|null - the user returned
     */
    public static function findByEmail($email): ?User
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        return static::findUser($stmt);
    }

    /**
     * @param mysqli_stmt $stmt - find info about an user
     * @return User|null - user object with info
     */
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

    /**
     * @param int $userId - the user id to be deleted
     * @return bool - if the user was deleted successfully or not
     */
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

    /**
     * @param $ageFromDatabase - age extracted from database
     * @return string - age for form usage
     */

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

    /**
     * @param mixed $genderFromDatabase - gender from database
     * @return string - gender for form usage
     */
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

    /**
     * @param mixed $skinTypeFromDatabase - skintype from database
     * @return string - actual skintype
     */

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