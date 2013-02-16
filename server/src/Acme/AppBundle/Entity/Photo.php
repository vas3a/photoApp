<?php

namespace Acme\AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Photo
 *
 * @ORM\Table()
 * @ORM\Entity(repositoryClass="Acme\AppBundle\Entity\PhotoRepository")
 */
class Photo
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="title", type="string", length=55)
     */
    private $title;

    /**
     * @var string
     *
     * @ORM\Column(name="slug", type="string", length=75)
     */
    private $slug;

    /**
     * @var string
     *
     * @ORM\Column(name="imgsrc", type="string", length=255)
     */
    private $imgsrc;

    /**
     * @var string
     *
     * @ORM\Column(name="thumbsrc", type="string", length=255)
     */
    private $thumbsrc;

    /**
     * @var integer
     *
     * @ORM\Column(name="views", type="integer")
     */
    private $views;


    /**
     * Set id
     *
     * @param integer $id
     * @return Photo 
     */
    public function setId($id)
    {
        $this->id = $id;
        return $this;
    }
    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set title
     *
     * @param string $title
     * @return Photo
     */
    public function setTitle($title)
    {
        $this->title = $title;
    
        return $this;
    }

    /**
     * Get title
     *
     * @return string 
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Set slug
     *
     * @param string $slug
     * @return Photo
     */
    public function setSlug($slug)
    {
        $this->slug = $slug;
    
        return $this;
    }

    /**
     * Get slug
     *
     * @return string 
     */
    public function getSlug()
    {
        return $this->slug;
    }

    /**
     * Set imgsrc
     *
     * @param string $imgsrc
     * @return Photo
     */
    public function setImgsrc($imgsrc)
    {
        $this->imgsrc = $imgsrc;
    
        return $this;
    }

    /**
     * Get imgsrc
     *
     * @return string 
     */
    public function getImgsrc()
    {
        return $this->imgsrc;
    }

    /**
     * Set thumbsrc
     *
     * @param string $thumbsrc
     * @return Photo
     */
    public function setThumbsrc($thumbsrc)
    {
        $this->thumbsrc = $thumbsrc;
    
        return $this;
    }

    /**
     * Get thumbsrc
     *
     * @return string 
     */
    public function getThumbsrc()
    {
        return $this->thumbsrc;
    }

    /**
     * Get views
     *
     * @return integer 
     */
    public function getViews()
    {
        return $this->views;
    }

    /**
     * Set views
     *
     * @param integer $views
     * @return Photo
     */
    public function setViews($views)
    {
        $this->views = $views;
    
        return $this;
    }
}
