<?php
include_once 'Video.php';
include_once 'bd.php';


class VideoRepository
{
    //get all videos for a given occasion
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