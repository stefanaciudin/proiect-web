<?php

class Video
{

    protected mixed $video_id;
    protected mixed $link;
    protected mixed $occasion;

    /**
     * @return mixed
     */
    public function getVideoId(): mixed
    {
        return $this->video_id;
    }

    /**
     * @param mixed $video_id
     */
    public function setVideoId(mixed $video_id): void
    {
        $this->video_id = $video_id;
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

    /**
     * @return mixed
     */
    public function getOccasion(): mixed
    {
        return $this->occasion;
    }

    /**
     * @param mixed $occasion
     */
    public function setOccasion(mixed $occasion): void
    {
        $this->occasion = $occasion;
    }




}