<?php

class Video
{

    protected int $video_id;
    protected string $link;
    protected string $occasion;

    /**
     * @return int
     */
    public function getVideoId(): int
    {
        return $this->video_id;
    }

    /**
     * @param int $video_id
     */
    public function setVideoId(int $video_id): void
    {
        $this->video_id = $video_id;
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
     * @return string
     */
    public function getOccasion(): string
    {
        return $this->occasion;
    }

    /**
     * @param string $occasion
     */
    public function setOccasion(string $occasion): void
    {
        $this->occasion = $occasion;
    }


}