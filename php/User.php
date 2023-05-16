<?php
include_once 'bd.php';

class User
{
    protected mixed $user_id;
    protected mixed $name;
    protected mixed $surname;
    protected mixed $username;
    protected mixed $email;
    protected mixed $password;

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

    public function __toString(): string
    {
        return "User: " . $this->name . " " . $this->surname . " " . $this->username . " " . $this->email . " " . $this->password;
    }
}
