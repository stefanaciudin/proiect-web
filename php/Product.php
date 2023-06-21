<?php

class Product
{
    protected int $product_id;
    protected string $name;
    protected float $price;
    protected string $image_path;
    protected int $is_makeup;
    protected int $age;
    protected int $brand_id;
    protected int $skintype_id;
    protected int $type_id;
    protected mixed $ingredients;
    protected mixed $description;
    protected mixed $how_to_use;
    protected string $link;
    protected int $times_recommended;

    /**
     * @return int
     */
    public function getProductId(): int
    {
        return $this->product_id;
    }

    /**
     * @param int $product_id
     */
    public function setProductId(int $product_id): void
    {
        $this->product_id = $product_id;
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
     * @return float
     */
    public function getPrice(): float
    {
        return $this->price;
    }

    /**
     * @param float $price
     */
    public function setPrice(float $price): void
    {
        $this->price = $price;
    }

    /**
     * @return string
     */
    public function getImagePath(): string
    {
        return $this->image_path;
    }

    /**
     * @param string $image_path
     */
    public function setImagePath(string $image_path): void
    {
        $this->image_path = $image_path;
    }

    /**
     * @return int
     */
    public function getIsMakeup(): int
    {
        return $this->is_makeup;
    }

    /**
     * @param int $is_makeup
     */
    public function setIsMakeup(int $is_makeup): void
    {
        $this->is_makeup = $is_makeup;
    }

    /**
     * @return int
     */
    public function getAge(): int
    {
        return $this->age;
    }

    /**
     * @param int $age
     */
    public function setAge(int $age): void
    {
        $this->age = $age;
    }

    /**
     * @return int
     */
    public function getBrandId(): int
    {
        return $this->brand_id;
    }

    /**
     * @param int $brand_id
     */
    public function setBrandId(int $brand_id): void
    {
        $this->brand_id = $brand_id;
    }

    /**
     * @return int
     */
    public function getSkintypeId(): int
    {
        return $this->skintype_id;
    }

    /**
     * @param int $skintype_id
     */
    public function setSkintypeId(int $skintype_id): void
    {
        $this->skintype_id = $skintype_id;
    }

    /**
     * @return int
     */
    public function getTypeId(): int
    {
        return $this->type_id;
    }

    /**
     * @param int $type_id
     */
    public function setTypeId(int $type_id): void
    {
        $this->type_id = $type_id;
    }

    /**
     * @return string
     */
    public function getIngredients(): mixed
    {
        return $this->ingredients;
    }

    /**
     * @param string $ingredients
     */
    public function setIngredients(mixed $ingredients): void
    {
        $this->ingredients = $ingredients;
    }

    /**
     * @return string
     */
    public function getDescription(): mixed
    {
        return $this->description;
    }

    /**
     * @param string $description
     */
    public function setDescription(mixed $description): void
    {
        $this->description = $description;
    }

    /**
     * @return string
     */
    public function getHowToUse(): mixed
    {
        return $this->how_to_use;
    }

    /**
     * @param string $how_to_use
     */
    public function setHowToUse(mixed $how_to_use): void
    {
        $this->how_to_use = $how_to_use;
    }

    /**
     * @return string
     */
    public function getLink(): string
    {
        return $this->link;
    }

    /**
     * @param string $link
     */
    public function setLink(string $link): void
    {
        $this->link = $link;
    }

    /**
     * @return int
     */
    public function getTimesRecommended(): int
    {
        return $this->times_recommended;
    }

    /**
     * @param int $times_recommended
     */
    public function setTimesRecommended(int $times_recommended): void
    {
        $this->times_recommended = $times_recommended;
    }


}