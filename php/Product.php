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
     * @param int $product_id
     */
    public function setProductId(int $product_id): void
    {
        $this->product_id = $product_id;
    }

    /**
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /**
     * @param float $price
     */
    public function setPrice(float $price): void
    {
        $this->price = $price;
    }


    /**
     * @param string $image_path
     */
    public function setImagePath(string $image_path): void
    {
        $this->image_path = $image_path;
    }

    /**
     * @param int $is_makeup
     */
    public function setIsMakeup(int $is_makeup): void
    {
        $this->is_makeup = $is_makeup;
    }

    public function setAge(int $age): void
    {
        $this->age = $age;
    }

    /**
     * @param int $brand_id
     */
    public function setBrandId(int $brand_id): void
    {
        $this->brand_id = $brand_id;
    }


    /**
     * @param int $skintype_id
     */
    public function setSkintypeId(int $skintype_id): void
    {
        $this->skintype_id = $skintype_id;
    }

    /**
     * @param int $type_id
     */
    public function setTypeId(int $type_id): void
    {
        $this->type_id = $type_id;
    }

    /**
     * @param string $ingredients
     */
    public function setIngredients(mixed $ingredients): void
    {
        $this->ingredients = $ingredients;
    }

    /**
     * @param string $description
     */
    public function setDescription(mixed $description): void
    {
        $this->description = $description;
    }

    /**
     * @param string $how_to_use
     */
    public function setHowToUse(mixed $how_to_use): void
    {
        $this->how_to_use = $how_to_use;
    }


    /**
     * @param string $link
     */
    public function setLink(string $link): void
    {
        $this->link = $link;
    }

    /**
     * @param int $times_recommended
     */
    public function setTimesRecommended(int $times_recommended): void
    {
        $this->times_recommended = $times_recommended;
    }


}