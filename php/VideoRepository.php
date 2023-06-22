<?php
include_once 'bd.php';


class VideoRepository
{
    /**
     * @param $occasion - the occasion for which the videos are searched
     * @return array - an array of Videos
     */
    public static function getVideosByOccasionArray($occasion):array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM videos WHERE ocazie=?");
        $stmt->bind_param("s", $occasion);
        $stmt->execute();
        $stmt->bind_result($video_id, $link, $ocazie);
        $videos = array();
        while ($stmt->fetch()) {
            $videoArray = array(
                'id' => $video_id,
                'link' => $link,
                'occasion' => $ocazie,
            );
            $videos[] = $videoArray;
        }
        return $videos;
    }

}