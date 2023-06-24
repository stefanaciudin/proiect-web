<?php

class User
{
    public $user_id;
    public $name;
    public $surname;
    public $username;
    public $email;
    public $password;
    public $age = 0;
    public $gender;
    public $skin_type = 2;
    public $location;
    public $token;
    public $admin = 0;


    public function __construct($name, $surname, $username, $email, $password, $token, $admin)
    {
        $this->name = $name;
        $this->username = $username;
        $this->surname = $surname;
        $this->email = $email;
        $this->password = $password;
        $this->token = $token;
        $this->admin = $admin;
    }

    public function __toString(): string
    {
        return "User: " . $this->name . " " . $this->surname . " " . $this->username . " " . $this->email . " " . $this->password;
    }

    /**
     * @return int
     */
    public function getUserId(): int
    {
        return $this->user_id;
    }

    /**
     * @param int $user_id
     */
    public function setUserId(int $user_id): void
    {
        $this->user_id = $user_id;
    }

    /**
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }

    /**
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /**
     * @return string
     */
    public function getSurname(): string
    {
        return $this->surname;
    }

    /**
     * @param string $surname
     */
    public function setSurname(string $surname): void
    {
        $this->surname = $surname;
    }

    /**
     * @return string
     */
    public function getUsername(): string
    {
        return $this->username;
    }

    /**
     * @param string $username
     */
    public function setUsername(string $username): void
    {
        $this->username = $username;
    }

    /**
     * @return string
     */
    public function getEmail(): string
    {
        return $this->email;
    }

    /**
     * @param string $email
     */
    public function setEmail(string $email): void
    {
        $this->email = $email;
    }

    /**
     * @return string
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    /**
     * @param string $password
     */
    public function setPassword(string $password): void
    {
        $this->password = $password;
    }

    /**
     * @return 
     */
    public function getAge() 
    {
        return $this->age;
    }

    /**
     * @param $age
     */
    public function setAge($age): void
    {
        $this->age = $age;
    }

    /**
     * @return string
     */
    public function getGender(): string
    {
        return $this->gender;
    }

    /**
     * @param string $gender
     */
    public function setGender(string $gender): void
    {
        $this->gender = $gender;
    }

    /**
     * @return 
     */
    public function getSkinType()
    {
        return $this->skin_type;
    }

    /**
     * @param  $skin_type
     */
    public function setSkinType( $skin_type): void
    {
        $this->skin_type = $skin_type;
    }

    /**
     * @return string
     */
    public function getLocation()
    {
        return $this->location;
    }

    /**
     * @param string $location
     */
    public function setLocation( $location): void
    {
        $this->location = $location;
    }

    /**
     * @return string
     */
    public function getToken(): string
    {
        return $this->token;
    }

    /**
     * @param string $token
     */
    public function setToken(string $token): void
    {
        $this->token = $token;
    }

        /**
     * @param int $admin
     */
    public function setAdmin(int $admin): void
    {
        $this->admin = $admin;
    }
}