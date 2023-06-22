<?php
include_once 'Video.php';
include_once 'bd.php';


class VideoRepository
{
    /**
     * @param $occasion - the occasion for which the videos are searched
     * @return array - an array of Video objects
     */
    public static function getVideosByOccasion($occasion): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM videos WHERE ocazie=?");
        $stmt->bind_param("s", $occasion);
        $stmt->execute();
        $stmt->bind_result($video_id, $link, $ocazie);
        $videos = array();
        while ($stmt->fetch()) {
            $video = new Video();
            $video->setVideoId($video_id);
            $video->setLink($link);
            $video->setOccasion($ocazie);
            $videos[] = $video;
        }
        return $videos;
    }

}