<?php

class Product
{
    protected mixed $product_id;
    protected mixed $name;
    protected mixed $price;
    protected mixed $image_path;
    protected mixed $is_makeup;
    protected mixed $age;
    protected mixed $brand_id;
    protected mixed $skintype_id;
    protected mixed $type_id;
    protected mixed $ingredients;
    protected mixed $description;
    protected mixed $how_to_use;
    protected mixed $link;

    /**
     * @param mixed $product_id
     */
    public function setProductId(mixed $product_id): void
    {
        $this->product_id = $product_id;
    }

    /**
     * @param mixed $name
     */
    public function setName(mixed $name): void
    {
        $this->name = $name;
    }

    /**
     * @param mixed $price
     */
    public function setPrice(mixed $price): void
    {
        $this->price = $price;
    }

    /**
     * @param mixed $image_path
     */
    public function setImagePath(mixed $image_path): void
    {
        $this->image_path = $image_path;
    }

    /**
     * @param mixed $is_makeup
     */
    public function setIsMakeup(mixed $is_makeup): void
    {
        $this->is_makeup = $is_makeup;
    }

    /**
     * @param mixed $age
     */
    public function setAge(mixed $age): void
    {
        $this->age = $age;
    }

    /**
     * @param mixed $brand_id
     */
    public function setBrandId(mixed $brand_id): void
    {
        $this->brand_id = $brand_id;
    }

    /**
     * @param mixed $skintype_id
     */
    public function setSkintypeId(mixed $skintype_id): void
    {
        $this->skintype_id = $skintype_id;
    }

    /**
     * @param mixed $type_id
     */
    public function setTypeId(mixed $type_id): void
    {
        $this->type_id = $type_id;
    }

    /**
     * @param mixed $ingredients
     */
    public function setIngredients(mixed $ingredients): void
    {
        $this->ingredients = $ingredients;
    }

    /**
     * @param mixed $description
     */
    public function setDescription(mixed $description): void
    {
        $this->description = $description;
    }

    /**
     * @param mixed $how_to_use
     */
    public function setHowToUse(mixed $how_to_use): void
    {
        $this->how_to_use = $how_to_use;
    }

    /**
     * @return mixed
     */
    public function getProductId(): mixed
    {
        return $this->product_id;
    }

    /**
     * @return mixed
     */
    public function getName(): mixed
    {
        return $this->name;
    }

    /**
     * @return mixed
     */
    public function getPrice(): mixed
    {
        return $this->price;
    }

    /**
     * @return mixed
     */
    public function getImagePath(): mixed
    {
        return $this->image_path;
    }

    /**
     * @return mixed
     */
    public function getIsMakeup(): mixed
    {
        return $this->is_makeup;
    }

    /**
     * @return mixed
     */
    public function getAge(): mixed
    {
        return $this->age;
    }

    /**
     * @return mixed
     */
    public function getBrandId(): mixed
    {
        return $this->brand_id;
    }

    /**
     * @return mixed
     */
    public function getSkintypeId(): mixed
    {
        return $this->skintype_id;
    }

    /**
     * @return mixed
     */
    public function getTypeId(): mixed
    {
        return $this->type_id;
    }

    /**
     * @return mixed
     */
    public function getIngredients(): mixed
    {
        return $this->ingredients;
    }

    /**
     * @return mixed
     */
    public function getDescription(): mixed
    {
        return $this->description;
    }

    /**
     * @return mixed
     */
    public function getHowToUse(): mixed
    {
        return $this->how_to_use;
    }

    /**
     * @return mixed
     */
    public function getLink(): mixed
    {
        return $this->link;
    }

    /**
     * @param mixed $link
     */
    public function setLink(mixed $link): void
    {
        $this->link = $link;
    }



}