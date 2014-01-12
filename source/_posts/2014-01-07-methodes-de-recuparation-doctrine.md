---
title: Méthode de récupération des objets en bdd
published: true
categories: [Mémo, Doctrine]
---

## Depuis le controlleur

* $repository->find(5);
* $repository->findAll();
* $repository->findBy(array $criteres, array $orderBy = null, $limite = null, $offset = null);
* $repository->findOneBy(array $criteres);
* $repository->findByXXX('ZZZ');
* $repository->findOneByXXX('ZZZ');

## Depuis le modèle
* $qb->getQuery()->getResult();
* $qb->getQuery()->getArrayResult();
* $qb->getQuery()->getScalarResult();
* $qb->getQuery()->getSingleScalarResult();
* $qb->getQuery()->getOneOrNullResult();
* $qb->getQuery()->getSingleResult();