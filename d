GUIDE D’EXPLOITATION
ET D’ADMINISTRATION

IBM SPECTRUM PROTECT (TSM)

Procédures opérationnelles — Exploitation, supervision,
réplication, bandes et automatisation

Périmètre : plateforme TSM multi-sites — détails d’environnement à compléter

Version 1.0  |  17 novembre 2026
Classification : INTERNE — [À CONFIRMER]**

Contrôle documentaire

| Champ | Valeur |

| — | — |

| Titre | Guide d’exploitation et d’administration — IBM Spectrum Protect (TSM) |

| Version | 1.0 — trame initiale |

| Date | 17/11/2026 |

| Propriétaire | Équipe Infrastructure / Sauvegarde — [À COMPLÉTER]**
|

| Rédacteur | [À COMPLÉTER]**
|

| Validateur technique | [À COMPLÉTER]**
|

| Version IBM Spectrum Protect | [À COMPLÉTER — version exacte serveur et clients]**
|

| Environnements couverts | [À COMPLÉTER — production / préproduction / sites]**
|

| Diffusion | [À COMPLÉTER]**
|

Historique des versions

| Version | Date | Auteur | Description | Validation |

| — | — | — | — | — |

| 1.0 | 17/11/2026 | [À COMPLÉTER]**
| Création de la trame opérationnelle ; champs propres à l’environnement laissés ouverts. | [À COMPLÉTER]**
|

|  |  |  |  |  |

Règles d’utilisation et de sécurité

• Ce document est une base opérationnelle à valider avant toute utilisation en production. Les champs [À COMPLÉTER]**
doivent être renseignés et approuvés par le responsable de la plateforme.
• Les commandes de consultation sont identifiées comme telles. Toute commande de création, modification, déplacement, check-in/check-out ou déclenchement de traitement est considérée comme modifiante ou potentiellement impactante.
• Ne jamais saisir un mot de passe réel dans ce document, une capture d’écran, un ticket ou un historique de commande partagé.
• Avant une opération sur bande, réplication ou stockage, confirmer le serveur ciblé, le site, la librairie, le volume et la fenêtre de changement.
• Les exemples de sortie sont explicitement fictifs et ne constituent pas une référence de résultat attendu dans l’environnement.

Sommaire

Sommaire automatique — dans Word : clic droit > Mettre à jour les champs > Mettre à jour toute la table.

Note : le sommaire et les numéros de page sont des champs Word. Actualiser les champs à l’ouverture du document.

CHAPITRE 1 — Introduction

1.1 Objectifs

Ce guide décrit les opérations récurrentes nécessaires à l’exploitation de la plateforme IBM Spectrum Protect (anciennement Tivoli Storage Manager — TSM). Il vise à fournir à un administrateur nouvellement affecté un chemin de contrôle reproductible, depuis la supervision des sauvegardes jusqu’au suivi des supports et à l’installation des clients.

1.2 Périmètre et limites

Le périmètre comprend les serveurs Spectrum Protect, Operations Center, les clients de sauvegarde Linux et Windows, les agents Oracle et VMware, la réplication intersites, les pools de stockage sur bandes et les fonctions DRM. Les noms de serveurs, adresses, versions, fenêtres, chemins et objets internes non fournis sont indiqués [À COMPLÉTER]**
.

1.3 Composants de la plateforme

| Composant | Rôle opérationnel | Informations locales |

| — | — | — |

| IBM Spectrum Protect Server | Serveur central de gestion des politiques, métadonnées, sessions clients, événements et stockage. | Serveurs : [À COMPLÉTER]**
; versions : [À COMPLÉTER]**
|

| Operations Center | Interface Web de supervision des serveurs, clients, activités, alertes et réplication. | URL : [À COMPLÉTER]**
; accès : [À COMPLÉTER]**
|

| Backup-Archive Client (BA Client) | Client de sauvegarde/restauration de fichiers pour systèmes Linux et Windows. | Packages et versions : [À COMPLÉTER]**
|

| TDPO | Module Data Protection for Oracle permettant l’intégration des sauvegardes Oracle/RMAN avec Spectrum Protect. | Version / Oracle : [À COMPLÉTER]**
|

| TDP for VE | Protection des machines virtuelles VMware via l’intégration avec vCenter/ESXi et les composants Spectrum Protect. | Datacenter / vCenter : [À COMPLÉTER]**
|

| Réplication de nœuds | Copie des données d’un nœud depuis un serveur source vers un serveur cible afin de soutenir la reprise après sinistre. | Source : [À COMPLÉTER]**
; cible : [À COMPLÉTER]**
|

| COPYPOOL / bandes LTO7 | Copie de protection conservée sur un pool de stockage secondaire, notamment sur supports LTO7 selon la conception locale. | COPYPOOL : [À COMPLÉTER]**
|

| Librairie de bandes | Robotique, lecteurs, emplacements et inventaire des cartouches. | LTO7_PROD : [À CONFIRMER]**
|

| DRM | Gestion des médias de reprise après sinistre : suivi des cartouches, externalisation et retour de supports. | Politique DRM : [À COMPLÉTER]**
|

1.4 Architecture

Le schéma ci-dessous doit être remplacé par le schéma d’architecture validé. Il devra notamment identifier les deux sites, les serveurs TSM, les flux de réplication, les clients, les librairies, les pools, les réseaux et les dépendances VMware/Oracle.

|

> **[EMPLACEMENT DE CAPTURE — Figure 1 — Architecture TSM multi-sites (schéma à insérer)]**
> |

| — |

Figure 1 — Architecture TSM multi-sites (schéma à insérer)

1.5 Informations d’environnement à maintenir

| Élément | Valeur |

| — | — |

| Site primaire / secondaire | [À COMPLÉTER]**
|

| Serveur TSM primaire / secondaire | [À COMPLÉTER]**
|

| Version serveur / niveau de maintenance | [À COMPLÉTER]**
|

| URL Operations Center | [À COMPLÉTER]**
|

| Librairies / lecteurs / type de média | [À COMPLÉTER]**
|

| Pool primaire / COPYPOOL | [À COMPLÉTER]**
|

| Fenêtres de sauvegarde et réplication | [À COMPLÉTER]**
|

| Contacts d’escalade | [À COMPLÉTER]**
|

CHAPITRE 2 — Supervision du nœud ALGU3_ORA via Operations Center

Objectif

Contrôler l’état opérationnel du nœud ALGU3_ORA depuis Operations Center, vérifier la fraîcheur de sa dernière sauvegarde et identifier les alertes ou événements nécessitant une action.

Prérequis

• Compte Operations Center autorisé en lecture/supervision ; URL et méthode d’authentification connues.
• Connaître le serveur Spectrum Protect auquel le nœud est rattaché.
• Disposer du planning de sauvegarde approuvé pour ALGU3_ORA : [À COMPLÉTER]**
.

Étapes d’exécution

1. Ouvrir l’URL Operations Center : [URL À COMPLÉTER]**
, puis s’authentifier avec un compte nominatif.
2. Dans la vue des clients/nœuds, rechercher exactement ALGU3_ORA. Vérifier le serveur et le domaine de politiques affichés.
3. Ouvrir la fiche du nœud et relever son état, ses dernières activités et les éventuels indicateurs d’alerte.
4. Consulter l’historique des sauvegardes et comparer la date/heure de la dernière exécution au planning applicable.
5. Consulter les activités récentes et les détails des opérations en échec ou terminées avec avertissements.
6. Si une alerte existe, relever son horodatage, son composant, son message et son niveau de gravité avant toute action.

Commandes

Ne nécessite aucune commande administrative si l’ensemble des contrôles est réalisé depuis Operations Center. Les commandes correctives éventuelles sont hors périmètre de cette procédure et doivent être validées séparément.

Résultat attendu

Le nœud ALGU3_ORA est retrouvé sans ambiguïté ; son statut est cohérent avec le fonctionnement attendu ; la dernière sauvegarde est conforme au planning ; aucune alerte critique non traitée n’est présente.

Points de contrôle

• Confirmer le bon serveur et le bon nom de nœud avant d’interpréter les données.
• Comparer l’heure affichée au fuseau horaire configuré dans l’outil et au calendrier d’exploitation.
• Vérifier que la sauvegarde est terminée et pas seulement démarrée.
• Tracer le résultat dans la checklist quotidienne ou l’outil de ticketing.

Gestion des anomalies

• Nœud absent : vérifier le filtre de serveur, l’orthographe, le statut d’enregistrement et la visibilité du compte.
• Sauvegarde en retard : contrôler le planning, la connectivité client-serveur, les services client et les journaux du client.
• Échec : ouvrir le détail de l’événement, relever le code/message d’erreur, puis consulter les journaux client et serveur selon les droits.
• Alerte critique : appliquer la procédure d’escalade ; ne pas relancer une sauvegarde sans comprendre l’impact d’une éventuelle exécution déjà active.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 2 — Operations Center : recherche et fiche du nœud ALGU3_ORA]**
> |

| — |

Figure 2 — Operations Center : recherche et fiche du nœud ALGU3_ORA

|

> **[EMPLACEMENT DE CAPTURE — Figure 3 — Historique et statut des sauvegardes ALGU3_ORA]**
> |

| — |

Figure 3 — Historique et statut des sauvegardes ALGU3_ORA

| Contrôle | État attendu | Action en cas d’anomalie |

| — | — | — |

| État du nœud | Conforme / actif selon les conventions locales | Vérifier la connectivité, le statut du nœud et les alertes associées. |

| Dernière sauvegarde | Conforme au planning approuvé | Analyser les événements, l’historique et les journaux client. |

| Alertes | Aucune alerte critique non traitée | Consulter les détails, qualifier la gravité et ouvrir/escalader un incident. |

CHAPITRE 3 — Supervision des sauvegardes

3.1 Méthode 1 — Ligne de commande administrative TSM

Objectif

Interroger les événements planifiés afin de déterminer si les sauvegardes attendues ont été exécutées, manquées ou terminées en erreur.

Prérequis

• Accès à l’interface administrative du serveur concerné.
• Droits permettant d’exécuter QUERY EVENT.
• Connaissance de la période à analyser et du serveur d’événements concerné.

Étapes d’exécution

1. Se connecter au serveur administratif approprié.
2. Exécuter la requête de consultation et identifier les événements du périmètre concerné.
3. Filtrer visuellement les nœuds et schedules pertinents ; si le résultat est volumineux, utiliser les paramètres de période validés dans la documentation de la version.
4. Examiner le statut, l’heure de début/fin et le détail en format détaillé si nécessaire.
5. Pour chaque anomalie, corréler l’événement avec les journaux client/serveur et ouvrir un ticket si requis.

Commandes

CONSULTATION — commande fournie / à exécuter sur le serveur approprié

query event * *

Résultat attendu

Les événements attendus apparaissent avec un statut final cohérent avec le planning. Les événements manqués ou échoués sont identifiés et analysés ; aucun événement critique ne reste sans qualification.

Points de contrôle

• La commande retourne les événements du serveur visé ; elle ne prouve pas à elle seule la restaurabilité des données.
• Contrôler la période : la requête fournie peut retourner un volume important d’événements.
• Vérifier les événements de tous les schedules attendus, pas uniquement les sauvegardes ayant généré une alerte.
• Les statuts exacts et les codes de retour doivent être interprétés selon la version et le contexte d’exécution.

Gestion des anomalies

• Événement manqué : vérifier disponibilité du client, fenêtre, scheduler et réseau.
• Événement échoué : relever le code retour et le message ; examiner les journaux client et serveur.
• Absence d’événement : confirmer le serveur d’événements, l’association du nœud au schedule et la période interrogée.
• Résultat volumineux : restreindre la période avec les paramètres de QUERY EVENT documentés pour la version installée.

3.1.1 Lecture d’une sortie — exemple fictif

L’extrait ci-dessous est purement illustratif. Les valeurs, noms et statuts ne proviennent pas de la plateforme réelle et ne doivent pas être utilisés comme preuve d’exécution.

EXEMPLE DE SORTIE FICTIF — NE PAS CONFONDRE AVEC UNE SORTIE RÉELLE

Exemple FICTIF — présentation simplifiée

Node       Schedule       Scheduled Start       Actual Start         Status

ALGU3_ORA  ORA_NIGHTLY    17/11/2026 01:00       17/11/2026 01:02      Completed

LINUX_APP  DAILY_INC      17/11/2026 02:00       --                    Missed

WIN_FILE   DAILY_BACKUP  17/11/2026 03:00       17/11/2026 03:05      Failed

| Colonne illustrative | Interprétation |

| — | — |

| Node | Nom du nœud client concerné. |

| Schedule | Nom du schedule attendu. |

| Scheduled Start | Date/heure planifiée. |

| Actual Start | Date/heure réelle de démarrage ; vide si l’événement n’a pas démarré. |

| Status | État synthétique de l’événement. Les libellés exacts dépendent de la version et du contexte. |

3.1.2 Statuts et analyse

Un statut de réussite indique que l’événement s’est terminé conformément aux critères du serveur et au code retour transmis par le client. Un statut manqué indique que l’événement n’a pas été exécuté dans les conditions attendues. Un statut en échec nécessite l’analyse du détail de l’événement et des journaux. Certains environnements peuvent également présenter des avertissements ou des résultats partiels : ils doivent être qualifiés, pas assimilés automatiquement à une réussite complète.

3.2 Méthode 2 — Operations Center

Objectif

Utiliser l’interface graphique pour superviser les activités de sauvegarde, examiner les opérations terminées et isoler les clients en échec.

Prérequis

• Accès à Operations Center et droits de consultation des activités.
• Connaissance du serveur, de la période et des nœuds à surveiller.

Étapes d’exécution

1. Ouvrir la vue des activités ou des clients selon la version d’Operations Center.
2. Appliquer les filtres de période, de serveur, de type d’activité et de statut disponibles.
3. Afficher les opérations terminées et isoler les statuts en échec ou avec avertissement.
4. Ouvrir le détail d’une opération pour relever le nœud, l’heure, le type de traitement, le résultat et les messages disponibles.
5. Constituer la liste des nœuds nécessitant une intervention et transmettre les informations à l’équipe responsable.

Commandes

Pas de commande obligatoire. Les intitulés de menus pouvant varier selon la version, compléter les chemins exacts après validation sur l’instance locale.

Résultat attendu

Les activités attendues sont visibles, les opérations en échec sont identifiées et chaque anomalie est associée à un nœud, une période et un message exploitable.

Points de contrôle

• Comparer les activités à la fenêtre de sauvegarde officielle.
• Ne pas conclure à une sauvegarde réussie sur la seule base d’une activité démarrée.
• Vérifier les détails et le résultat final ; distinguer sauvegarde complète, partielle et en erreur.
• Enregistrer les anomalies et leur propriétaire.

Gestion des anomalies

• Vue vide : contrôler les filtres, le serveur sélectionné et les droits du compte.
• Opération bloquée/en cours : vérifier depuis combien de temps elle est active et suivre la procédure d’escalade avant interruption.
• Messages peu explicites : corréler avec QUERY EVENT et les journaux du client/serveur.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 4 — Consultation de QUERY EVENT dans l’interface administrative]**
> |

| — |

Figure 4 — Consultation de QUERY EVENT dans l’interface administrative

|

> **[EMPLACEMENT DE CAPTURE — Figure 5 — Supervision des activités via Operations Center]**
> |

| — |

Figure 5 — Supervision des activités via Operations Center

CHAPITRE 4 — Supervision de la réplication

La réplication de nœuds copie les données client éligibles d’un serveur source vers un serveur cible. Elle contribue à la protection intersites et à la disponibilité des données en cas d’indisponibilité du site primaire. La configuration exacte dépend fortement de la version : à partir de Spectrum Protect 8.1.13, la réplication peut être pilotée par des règles de stockage ; les versions antérieures utilisent le modèle historique de réplication initiée par commandes et schedules administratifs. La version installée doit donc être confirmée avant toute action. https://www.ibm.com/docs/en/storage-protect/8.1.27?topic=replication-enabling-node.

Objectif

Vérifier l’état de la réplication entre les serveurs source et destination, suivre le dernier cycle et identifier les erreurs sans déclencher de traitement non autorisé.

Prérequis

• Versions des serveurs source et cible compatibles ; noms des serveurs et sens de réplication confirmés.
• Accès Operations Center et/ou droits de consultation des objets de réplication.
• Connaître les nœuds inclus dans le périmètre et la fenêtre attendue.

Étapes d’exécution

1. Identifier la paire source/cible et confirmer le sens de réplication.
2. Vérifier que la réplication est activée pour le périmètre concerné et que les objets de configuration attendus existent.
3. Consulter la synthèse de réplication dans Operations Center et ouvrir le détail par serveur/nœud.
4. Relever la date/heure du dernier cycle, le volume traité, les éléments en attente et les erreurs signalées.
5. Si une réplication est en cours, suivre sa progression sans lancer un second traitement manuel.
6. Comparer le résultat au RPO ou à l’objectif de fraîcheur défini par l’exploitation.
7. En cas d’erreur, corréler avec la connectivité interserveurs, la capacité mémoire, la bande passante et les journaux.

Commandes

EMPLACEMENT RÉSERVÉ — COMMANDE MODIFIANTE

[COMMANDE DE RÉPLICATION À DÉFINIR — ne pas exécuter avant validation de la version et du modèle de réplication]**

Résultat attendu

Le dernier cycle est identifié, son statut est cohérent avec la fenêtre prévue et les nœuds prioritaires disposent d’une copie à jour sur la cible selon le RPO défini.

Points de contrôle

• Distinguer état de configuration, état d’exécution et fraîcheur réelle des données.
• Ne pas confondre la réplication de nœuds avec la protection d’un storage pool.
• Documenter source, cible, heure de début/fin, durée, volumes traités et erreurs.
• Avant tout déclenchement manuel, vérifier qu’aucun cycle équivalent n’est déjà actif et obtenir l’autorisation de changement.

Gestion des anomalies

• Échec de connexion : vérifier la communication serveur-à-serveur et la résolution de noms.
• Retard : examiner le backlog, la fenêtre, la bande passante, les ressources serveur et les opérations concurrentes.
• Échec sur un nœud : examiner son état de réplication, ses règles et les messages associés.
• Différence de version ou configuration non compatible : arrêter l’intervention et valider la matrice de compatibilité IBM.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 6 — État de réplication source/cible dans Operations Center]**
> |

| — |

Figure 6 — État de réplication source/cible dans Operations Center

4.1 Consultation versus déclenchement

| Nature de l’action | Exemple / emplacement | Impact |

| — | — | — |

| Consultation | Vue Replication d’Operations Center ; requête de statut documentée pour la version. | Lecture seule ; ne modifie pas les données. |

| Déclenchement manuel | [COMMANDE / ACTION À DÉFINIR ET FAIRE APPROUVER]**
. | Peut consommer réseau, CPU, mémoire, espace journal et ressources stockage ; peut entrer en concurrence avec les sauvegardes. |

Ne pas copier une commande trouvée pour une autre version ou un autre modèle. IBM documente une évolution du modèle à partir de la version 8.1.13 ; vérifier le niveau exact avant d’insérer la commande d’exploitation. Références : IBM — Enabling node replication et Checking replication status.

CHAPITRE 5 — Contrôle du COPYPOOL et des cartouches LTO7

5.1 Vérification du COPYPOOL

Objectif

Contrôler que le pool de copie destiné à la protection secondaire est disponible, cohérent et exempt de volumes en anomalie.

Prérequis

• Nom exact du COPYPOOL : [À COMPLÉTER]**
.
• Serveur et version concernés ; droits de consultation des storage pools et volumes.
• Connaître la stratégie de copie, la capacité attendue et les seuils internes.

Étapes d’exécution

1. Depuis Operations Center ou l’interface administrative, identifier le pool de copie concerné.
2. Consulter l’état du storage pool, sa capacité, l’occupation et les éventuels seuils d’alerte.
3. Afficher la liste des volumes associés et leur état.
4. Identifier les volumes indisponibles, en erreur, pleins ou nécessitant une action.
5. Comparer les volumes disponibles et la capacité libre aux besoins opérationnels.
6. Si une anomalie est détectée, ne pas lancer de migration, réclamation ou suppression de volume sans procédure approuvée.

Commandes

CONSULTATION — À COMPLÉTER

[COMMANDE DE CONSULTATION DU STORAGE POOL — À VALIDER POUR LA VERSION ET LE NOM DU POOL]**

CONSULTATION — À COMPLÉTER

[COMMANDE DE CONSULTATION DES VOLUMES — À VALIDER]**

Résultat attendu

Le COPYPOOL est disponible selon les seuils internes, les volumes attendus sont présents et aucun support en anomalie ne compromet la capacité de protection.

Points de contrôle

• Vérifier la cohérence entre le nombre de volumes connus par le serveur et l’inventaire physique.
• Contrôler l’état des lecteurs et de la librairie si des volumes sont inaccessibles.
• Contrôler les tendances d’occupation et pas uniquement la valeur instantanée.
• Vérifier que la copie secondaire correspond bien à la stratégie de protection approuvée.

Gestion des anomalies

• Pool indisponible : vérifier les volumes sous-jacents, la librairie, les lecteurs et les chemins SAN.
• Volume en erreur : relever le nom, l’état et le dernier message d’activité ; ne pas réutiliser le support sans diagnostic.
• Capacité insuffisante : alerter le responsable stockage et appliquer le processus de capacité.

5.2 Vérification des cartouches LTO7

Objectif

Consulter les volumes enregistrés dans la librairie logique LTO7_PROD et identifier les cartouches disponibles ou présentant une anomalie.

Prérequis

• Accès administratif en lecture au serveur concerné.
• Confirmer que LTO7_PROD est le nom exact de la librairie logique dans l’environnement.

Étapes d’exécution

1. Se connecter au serveur TSM concerné.
2. Exécuter la commande de consultation ci-dessous.
3. Vérifier les volumes listés, leur statut, leur propriétaire et leur emplacement lorsque ces informations sont affichées.
4. Identifier les cartouches en statut Scratch ou Private selon leur usage attendu ; interpréter les statuts à partir de la documentation et de la politique locale.
5. Comparer l’inventaire logique à l’inventaire physique de la librairie et au registre d’exploitation.

Commandes

CONSULTATION — commande fournie ; abréviation de QUERY LIBVOLUME

query libv LTO7_PROD

Résultat attendu

La commande retourne l’inventaire des volumes enregistrés dans LTO7_PROD. Les volumes attendus sont visibles et aucun statut inattendu ne reste sans analyse.

Points de contrôle

• Dans la documentation IBM, un volume Private est utilisé par IBM Storage Protect ; un volume Scratch est disponible pour allocation selon la configuration. Vérifier aussi le propriétaire, le dernier usage et l’emplacement.
• Un statut Scratch ne signifie pas nécessairement qu’une cartouche est physiquement présente si l’inventaire robotique n’est pas cohérent.
• Ne pas retirer une cartouche Private sans procédure de checkout/DRM et validation.

Gestion des anomalies

• Cartouche absente : comparer l’inventaire TSM à celui du robot et vérifier les événements de librairie.
• Statut inattendu : relever le volume et consulter l’état détaillé ainsi que les journaux.
• Erreur de lecteur ou de média : isoler l’incident, ne pas forcer le montage et escalader vers l’équipe stockage.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 7 — Statut du COPYPOOL]**
> |

| — |

Figure 7 — Statut du COPYPOOL

|

> **[EMPLACEMENT DE CAPTURE — Figure 8 — Résultat de QUERY LIBVOLUME LTO7_PROD]**
> |

| — |

Figure 8 — Résultat de QUERY LIBVOLUME LTO7_PROD

| Volume | Statut TSM | Emplacement | Propriétaire | Action / commentaire |

| — | — | — | — | — |

| [VOL001]**
| [Scratch / Private / autre]**
| [Slot]**
| [Serveur]**
| [À COMPLÉTER]**
|

| [VOL002]**
| [Statut]**
| [Slot]**
| [Serveur]**
| [À COMPLÉTER]**
|

| [VOL003]**
| [Statut]**
| [Slot]**
| [Serveur]**
| [À COMPLÉTER]**
|

CHAPITRE 6 — Procédure de check-in des cartouches

Objectif

Faire reconnaître par la librairie et par IBM Spectrum Protect des cartouches physiques nouvellement introduites, selon le mode d’exploitation retenu.

Prérequis

• Autorisation de manipulation et fenêtre d’intervention approuvée.
• Liste de cartouches, étiquettes, type de média et destination confirmés.
• Accès à la librairie et au serveur TSM ; procédure locale de sécurité et de traçabilité.
• Vérifier qu’aucune opération de robotique ou de sauvegarde ne rend la manipulation incompatible.

Étapes d’exécution

1. Comparer les identifiants physiques des cartouches à la liste approuvée ; contrôler l’absence de doublons ou d’étiquettes illisibles.
2. Vérifier le type de média et la compatibilité avec la librairie/lecteurs.
3. Insérer les cartouches dans les emplacements autorisés selon la procédure constructeur et les consignes du site.
4. Relever l’inventaire robotique après insertion ; ne pas forcer un magasin ou un mécanisme bloqué.
5. Exécuter la première commande de check-in validée par l’équipe, avec les paramètres correspondant au mode d’insertion et à la librairie.
6. Exécuter la seconde commande uniquement si elle est prévue par la procédure locale ; sinon laisser le champ non applicable.
7. Vérifier le résultat côté TSM avec une commande de consultation et comparer les volumes à l’inventaire physique.
8. Mettre à jour le registre des médias et clôturer l’intervention.

Commandes

COMMANDE MODIFIANTE — VALIDATION OBLIGATOIRE

[COMMANDE CHECK-IN 1 — À COMPLÉTER]**

COMMANDE MODIFIANTE — VALIDATION OBLIGATOIRE

[COMMANDE CHECK-IN 2 — À COMPLÉTER]**

CONSULTATION — vérification après check-in, si cette librairie est bien la cible

query libv LTO7_PROD

Résultat attendu

Les cartouches autorisées sont reconnues dans la librairie et par TSM ; les identifiants, statuts et emplacements sont cohérents avec le registre physique.

Points de contrôle

• Vérifier chaque numéro de série/étiquette avant insertion.
• Confirmer que le mode de check-in choisi correspond au mode physique réellement utilisé.
• Comparer l’inventaire du robot et la sortie TSM après l’opération.
• Conserver la trace de l’opérateur, de l’heure, des cartouches et du résultat.

Gestion des anomalies

• Étiquette illisible ou doublon : ne pas enregistrer la cartouche ; isoler et demander une identification.
• Cartouche non reconnue : vérifier compatibilité média, lecteur, inventaire robotique et messages de la librairie.
• Erreur de robot : arrêter la manipulation et suivre le runbook constructeur.
• Volume déjà connu ou propriétaire inattendu : ne pas réinitialiser, relabeliser ou écraser ; escalader immédiatement.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 9 — Insertion physique des cartouches dans la librairie]**
> |

| — |

Figure 9 — Insertion physique des cartouches dans la librairie

|

> **[EMPLACEMENT DE CAPTURE — Figure 10 — Résultat du check-in dans TSM]**
> |

| — |

Figure 10 — Résultat du check-in dans TSM

6.1 Avertissements

• Une opération de check-in modifie l’inventaire de la librairie et peut rendre un support disponible au serveur ; elle doit être contrôlée.
• Ne jamais effectuer un label, relabel, checkout ou déplacement sur une cartouche dont le contenu ou le statut n’est pas établi.
• Respecter les règles de transport, stockage, protection électrostatique et manipulation définies par le fabricant et le site.
• Les commandes exactes et les paramètres dépendent du type de librairie, du mode d’insertion et de la version Spectrum Protect : ne pas les déduire de ce guide.

CHAPITRE 7 — Contrôle des cartouches en état VAULT RETRIEVE

Disaster Recovery Manager (DRM) suit le cycle de vie des médias utilisés dans les scénarios de reprise après sinistre : identification des médias, préparation à l’externalisation, présence en coffre et opérations de retour. L’état DRM décrit une étape de cycle de vie ; il ne doit pas être confondu avec le statut de la cartouche dans l’inventaire de la librairie.

Objectif

Identifier les cartouches dont l’état DRM indique qu’elles doivent être récupérées du coffre (VAULTRETRIEVE), vérifier leur identité et confirmer leur traitement physique et logique.

Prérequis

• Accès de consultation aux informations DRM et à l’inventaire de la librairie.
• Connaître le prestataire/coffre, les délais de retour et la procédure de chaîne de possession.
• Disposer de la liste attendue et des autorisations de retour.

Étapes d’exécution

1. Consulter la liste des médias DRM et filtrer les médias ayant l’état VAULTRETRIEVE.
2. Relever chaque identifiant de volume, son type, son emplacement logique, son statut DRM et les informations d’externalisation.
3. Comparer la liste logique à la demande de retour et au bordereau du coffre/prestataire.
4. À réception, vérifier physiquement les étiquettes, l’intégrité des cartouches et la correspondance avec le bordereau.
5. Appliquer la procédure de réintégration/retour approuvée et contrôler le nouvel état DRM.
6. Vérifier séparément le statut de la cartouche dans la librairie, son emplacement et sa disponibilité opérationnelle.

Commandes

CONSULTATION — commande propre à l’environnement à valider

[COMMANDE DE CONSULTATION DRM — À COMPLÉTER]**

CONSULTATION — à définir

[COMMANDE DE CONTRÔLE LIBRAIRIE — À COMPLÉTER]**

Résultat attendu

La liste VAULTRETRIEVE est rapprochée des supports physiquement récupérés. Chaque cartouche est tracée, son état DRM est mis à jour par la procédure approuvée et son statut librairie est vérifié séparément.

Points de contrôle

• Contrôler l’identifiant complet de chaque volume ; ne pas se fier uniquement à l’ordre de la liste.
• Documenter date/heure de demande, réception, opérateur et prestataire.
• Confirmer l’éligibilité au retour auprès du propriétaire de la politique DRM.
• Vérifier que le statut DRM et le statut de librairie sont cohérents avec la phase réelle du processus.

Gestion des anomalies

• Volume manquant : ouvrir un incident prestataire et ne pas clôturer la demande.
• Volume reçu mais non reconnu : vérifier l’inventaire de la librairie et l’état physique avant toute commande.
• Écart d’identifiant : isoler le support et faire confirmer la chaîne de possession.
• État DRM inchangé : utiliser uniquement la commande de transition documentée et autorisée pour la version installée.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 11 — Liste des cartouches en état VAULTRETRIEVE]**
> |

| — |

Figure 11 — Liste des cartouches en état VAULTRETRIEVE

7.1 Distinction des états

Les états DRM tels que VAULT, COURIER, ONSITE, MOUNTABLE ou VAULTRETRIEVE correspondent à des étapes ou conditions de gestion des médias selon la configuration. La signification exacte, les transitions possibles et les actions associées doivent être confirmées dans la documentation DRM de la version installée. Le statut de QUERY LIBVOLUME (par exemple Scratch/Private) décrit quant à lui l’inventaire de la librairie. Les deux informations sont complémentaires et non interchangeables.

CHAPITRE 8 — Enregistrement des nœuds Linux et Windows

8.1 Principes

L’enregistrement d’un nœud crée l’identité client connue du serveur Spectrum Protect. Le nœud est ensuite rattaché à un domaine de politiques et, selon l’organisation, à un ou plusieurs schedules. Le nom, le domaine, les règles de sécurité et les paramètres d’authentification doivent être approuvés avant l’enregistrement.

8.2 Enregistrement d’un nœud Linux

Objectif

Enregistrer un serveur Linux comme nœud client, puis préparer son rattachement aux politiques et schedules de sauvegarde.

Prérequis

• Fiche serveur validée : nom, OS/version, IP/DNS, propriétaire applicatif, criticité, environnement.
• Connectivité réseau testée vers le serveur TSM et ports autorisés selon la configuration locale.
• Domaine de politiques et conventions de nommage confirmés.
• Mot de passe initial géré selon la politique interne ; ne pas l’inscrire en clair dans un ticket ou ce document.

Étapes d’exécution

1. Collecter les informations du serveur et confirmer le nom de nœud attendu.
2. Vérifier la résolution DNS et la connectivité vers le serveur TSM.
3. Confirmer le domaine de politiques avec le propriétaire de la sauvegarde.
4. Depuis l’interface administrative, enregistrer le nœud avec les paramètres validés.
5. Configurer côté client les informations de connexion au serveur, le nom du nœud et les paramètres de sécurité selon la version du BA Client.
6. Tester la connexion avec une méthode approuvée et vérifier l’existence du nœud côté serveur.
7. Associer le nœud au schedule approprié et suivre sa première exécution planifiée.

Commandes

EXEMPLE GÉNÉRIQUE — COMMANDE MODIFIANTE ; syntaxe/paramètres à confirmer selon version et authentification

register node <NOM_NOEUD> <MOT_DE_PASSE> domain=<DOMAINE>

EXEMPLE GÉNÉRIQUE — COMMANDE MODIFIANTE ; association schedule

define association <DOMAINE> <SCHEDULE> <NOM_NOEUD>

Résultat attendu

Le nœud apparaît sur le serveur avec le domaine attendu, les paramètres client sont cohérents et la première exécution planifiée est observée et qualifiée.

Points de contrôle

• Confirmer le nom exact et l’absence de doublon avant REGISTER NODE.
• Confirmer l’authentification locale ou LDAP ; ne pas saisir de secret réel dans une commande copiée dans un document partagé.
• Vérifier la version client/serveur et les paramètres de sécurité de session.
• Confirmer l’association schedule via une consultation dédiée validée pour la version.

Gestion des anomalies

• Échec de connexion : vérifier DNS, routage, pare-feu, ports et configuration client.
• Nœud déjà existant : ne pas supprimer ou réenregistrer ; vérifier le propriétaire et l’historique.
• Mot de passe rejeté : vérifier la méthode d’authentification et la politique de complexité/expiration.
• Schedule non exécuté : vérifier association, fenêtre, scheduler client et serveur d’événements.

| Champ | Valeur à renseigner |

| — | — |

| Nom du nœud | [À COMPLÉTER]**
|

| Domaine de politiques | [À COMPLÉTER]**
|

| Mot de passe initial | [À DÉFINIR SELON LA POLITIQUE INTERNE — secret hors document]**
|

| Serveur TSM | [À COMPLÉTER]**
|

| Adresse / DNS | [À COMPLÉTER]**
|

| Schedule | [À COMPLÉTER]**
|

8.3 Enregistrement d’un nœud Windows

Objectif

Enregistrer un serveur Windows et préparer son client BA Client avec les paramètres approuvés.

Prérequis

• Fiche serveur Windows et propriétaire applicatif validés.
• Connectivité réseau vers le serveur TSM et droits d’installation administrateur local.
• Version du BA Client compatible avec l’OS et le serveur.

Étapes d’exécution

1. Collecter le nom d’hôte, la version Windows, les volumes à protéger et le propriétaire.
2. Vérifier DNS, réseau et règles de pare-feu.
3. Enregistrer le nœud sur le serveur selon la convention de nommage.
4. Installer/configurer le BA Client Windows avec le fichier d’options et les paramètres approuvés.
5. Vérifier le service scheduler et la connectivité.
6. Associer le nœud au domaine et au schedule validés ; contrôler la première exécution.

Commandes

EXEMPLE GÉNÉRIQUE — COMMANDE MODIFIANTE ; à valider

register node <NOM_NOEUD> <MOT_DE_PASSE> domain=<DOMAINE>

EXEMPLE GÉNÉRIQUE — COMMANDE MODIFIANTE ; à valider

define association <DOMAINE> <SCHEDULE> <NOM_NOEUD>

Résultat attendu

Le nœud Windows est visible, le client communique avec le serveur, le scheduler est opérationnel et le premier événement planifié est traité.

Points de contrôle

• Vérifier l’identité du serveur et les exclusions/volumes à protéger.
• Ne pas réutiliser un nom de nœud déjà affecté à un autre serveur.
• Vérifier les journaux client et l’état du service scheduler.
• Confirmer la politique de sauvegarde et les fenêtres de traitement.

Gestion des anomalies

• Échec d’installation : vérifier prérequis OS, droits, package et compatibilité.
• Service arrêté : consulter l’observateur d’événements Windows et les journaux du client.
• Événement manqué : contrôler le scheduler, l’association et la disponibilité du serveur.

8.4 Affectation des schedules

Un schedule définit une action planifiée et ses paramètres. L’association relie un nœud (ou groupe de nœuds) à un schedule dans un domaine de politiques. Le simple enregistrement du nœud ne garantit pas qu’une sauvegarde sera exécutée : il faut confirmer l’association et le traitement du premier événement.

Objectif

Associer un nœud nouvellement enregistré à un schedule existant et vérifier son exécution.

Prérequis

• Nom exact du domaine, du schedule et du nœud confirmés.
• Schedule existant, actif et validé par l’équipe sauvegarde.
• Fenêtre d’exécution et serveur d’événements connus.

Étapes d’exécution

1. Consulter le schedule existant et vérifier ses paramètres.
2. Vérifier que le nœud est affecté au domaine attendu.
3. Créer l’association via la commande validée ou l’interface d’administration.
4. Contrôler l’association dans la configuration.
5. Surveiller la première exécution avec QUERY EVENT et/ou Operations Center.

Commandes

COMMANDE MODIFIANTE — exemple générique à valider

define association <DOMAINE> <SCHEDULE> <NOM_NOEUD>

CONSULTATION — à valider selon version

[COMMANDE DE CONSULTATION ASSOCIATION / SCHEDULE — À COMPLÉTER]**

Résultat attendu

Le nœud est associé au schedule prévu et un événement est généré puis traité à la date attendue.

Points de contrôle

• Vérifier le domaine, le nom du schedule et le nom du nœud caractère par caractère.
• Contrôler que le schedule est activé et que le serveur d’événements est correct.
• Confirmer le résultat final du premier événement.

Gestion des anomalies

• Association absente : contrôler le domaine et la syntaxe utilisée.
• Pas d’événement : contrôler le calendrier, le serveur d’événements et le scheduler client.
• Échec d’exécution : reprendre la procédure de supervision des sauvegardes.

| Nœud | OS | Domaine | Schedule | Vérification |

| — | — | — | — | — |

| [Nœud]**
| Linux | [Domaine]**
| [Schedule]**
| [Statut]**
|

| [Nœud]**
| Windows | [Domaine]**
| [Schedule]**
| [Statut]**
|

|

> **[EMPLACEMENT DE CAPTURE — Figure 12 — Enregistrement du nœud dans l’interface administrative]**
> |

| — |

Figure 12 — Enregistrement du nœud dans l’interface administrative

|

> **[EMPLACEMENT DE CAPTURE — Figure 13 — Association du schedule]**
> |

| — |

Figure 13 — Association du schedule

CHAPITRE 9 — Installation et configuration du BA Client et TDPO sur Linux via Ansible

9.1 Rôle des composants

| Composant | Rôle |

| — | — |

| Backup-Archive Client | Agent client pour sauvegarder et restaurer les systèmes de fichiers et données supportées. |

| IBM Spectrum Protect API | Bibliothèque/API utilisée par certains composants et intégrations pour communiquer avec le serveur. |

| TDPO (Data Protection for Oracle) | Intégration Oracle permettant à RMAN d’utiliser Spectrum Protect comme destination de sauvegarde via les composants requis. |

9.2 Prérequis

• Connectivité réseau du serveur Linux vers le serveur Spectrum Protect, résolution DNS et ports autorisés.
• Packages et versions approuvés pour le système d’exploitation et la version du serveur.
• Droits administrateur nécessaires à l’installation, à la création/configuration des fichiers et à l’activation des services.
• Accès aux dépôts ou aux packages internes ; intégrité et provenance des packages vérifiées.
• Accès aux variables et secrets Ansible via le mécanisme sécurisé de l’organisation.
• Pour TDPO : version Oracle/RMAN supportée, bibliothèques Oracle nécessaires, compte Oracle et droits validés, architecture 64 bits/compatibilités confirmées.
• Prévoir une fenêtre de changement et un plan de retour arrière documenté.

9.3 Déploiement Ansible

Objectif

Déployer de façon répétable les packages BA Client, API et TDPO sur un serveur Linux au moyen de l’automatisation Ansible interne.

Prérequis

• Accès à la plateforme Ansible Automation Platform / contrôleur utilisé : [À COMPLÉTER]**
.
• Inventaire, groupe cible, job template, rôles et variables validés par l’équipe.
• Credentials et secrets disponibles dans le coffre ou mécanisme approuvé.
• Package, checksum et matrice de compatibilité validés.

Étapes d’exécution

1. Identifier le serveur cible et confirmer son nom/IP dans l’inventaire.
2. Vérifier que le serveur est dans le bon groupe d’inventaire et dans le bon environnement.
3. Sélectionner le job template approprié : [JOB TEMPLATE ANSIBLE — À COMPLÉTER]**
.
4. Renseigner les variables nécessaires sans exposer les secrets dans les paramètres visibles ou les logs.
5. Effectuer une revue croisée des paramètres : version, serveur TSM, nom de nœud, chemins, options TDPO et cible.
6. Lancer le job selon le processus de changement.
7. Consulter les logs du job, les tâches en échec, les changements effectués et les éventuels handlers.
8. Valider l’installation sur le serveur cible et consigner le résultat.

Commandes

RÉFÉRENCE INTERNE — NE PAS INVENTER

[JOB TEMPLATE ANSIBLE — À COMPLÉTER]**

PARAMÈTRES INTERNES — secrets via coffre approuvé

[VARIABLES ANSIBLE — À COMPLÉTER]**

Résultat attendu

Le job se termine sans tâche en échec inattendue, les packages sont présents à la version approuvée, les fichiers de configuration sont cohérents et le client communique avec le serveur.

Points de contrôle

• Confirmer le bon inventaire et le bon hôte avant le lancement.
• Examiner les changements Ansible et les tâches ayant modifié le système.
• Vérifier qu’aucun secret n’est affiché dans les logs.
• Comparer les versions installées à la matrice de compatibilité.
• En cas d’échec partiel, ne pas relancer aveuglément : identifier les tâches déjà appliquées et l’idempotence du rôle.

Gestion des anomalies

• Figure 14 — Job Template Ansible
• Figure 15 — Exécution et logs Ansible

9.4 Variables à documenter

| Variable | Description | Valeur |

| — | — | — |

| [VARIABLE_NODE]**
| Nom du nœud Spectrum Protect | [À COMPLÉTER]**
|

| [VARIABLE_TSM_SERVER]**
| Nom/DNS du serveur TSM | [À COMPLÉTER]**
|

| [VARIABLE_CLIENT_VERSION]**
| Version du BA Client/API | [À COMPLÉTER]**
|

| [VARIABLE_TDPO_VERSION]**
| Version TDPO | [À COMPLÉTER]**
|

| [VARIABLE_ORACLE_HOME]**
| Oracle Home utilisé par RMAN/TDPO | [À COMPLÉTER]**
|

| [VARIABLE_CONFIG_PATH]**
| Chemin de configuration client/TDPO | [À COMPLÉTER]**
|

| [VARIABLE_SECRET_REF]**
| Référence au secret dans le coffre, jamais la valeur en clair | [À COMPLÉTER]**
|

9.5 Vérification du BA Client

Objectif

Confirmer que le BA Client et l’API sont installés et correctement configurés sur le serveur Linux.

Prérequis

• Accès root/sudo ou compte d’exploitation autorisé.
• Nom du nœud, serveur TSM et chemins de configuration connus.
• Fenêtre de test et autorisation de connexion/sauvegarde confirmées.

Étapes d’exécution

1. Vérifier la présence des packages installés avec l’outil de gestion de paquets de la distribution.
2. Vérifier la présence et les permissions des fichiers de configuration attendus.
3. Contrôler le nom de nœud, l’adresse/nom du serveur et les options de connexion.
4. Vérifier les services ou processus associés selon la version et le mode d’exploitation.
5. Tester la connectivité avec la commande client documentée pour la version ; ne pas improviser de syntaxe.
6. Effectuer une sauvegarde de test uniquement si elle est autorisée et si le périmètre de données est maîtrisé.

Commandes

CONSULTATION

[COMMANDE DE VÉRIFICATION DES PACKAGES — À COMPLÉTER SELON RHEL/OS]**

TEST DE CONNEXION — validation préalable

[COMMANDE DE TEST CLIENT — À COMPLÉTER SELON VERSION]**

Résultat attendu

Les packages attendus sont présents, les fichiers sont conformes, le client utilise le bon nom de nœud et une connexion de test autorisée aboutit.

Points de contrôle

• Comparer le contenu réel des fichiers à la configuration approuvée.
• Vérifier propriétaires, permissions et droits de lecture des fichiers sensibles.
• Vérifier les journaux client et l’heure système.
• Ne pas afficher les mots de passe ou tokens dans les captures.

Gestion des anomalies

• Figure 16 — Résultat du déploiement BA Client

9.6 Vérification TDPO

Objectif

Valider l’installation et l’intégration de TDPO avec Oracle RMAN et Spectrum Protect.

Prérequis

• Versions Oracle, RMAN, TDPO, API et serveur TSM compatibles selon la matrice IBM.
• Compte Oracle et droits nécessaires validés par l’équipe DBA.
• Fichiers de configuration et paramètres de connexion disponibles via le coffre et les procédures internes.
• Test de connexion ou sauvegarde expressément autorisé.

Étapes d’exécution

1. Vérifier la présence des composants TDPO et des bibliothèques requises.
2. Contrôler les fichiers de configuration TDPO et les paramètres pointant vers le serveur TSM.
3. Vérifier l’environnement Oracle utilisé par RMAN et l’intégration du module SBT selon la documentation IBM correspondant à la version.
4. Consulter les journaux TDPO, client et Oracle/RMAN.
5. Réaliser un test de connexion ou de sauvegarde non destructive selon la procédure DBA approuvée.
6. Consigner les versions, paramètres non sensibles et résultats.

Commandes

CONSULTATION / TEST — à valider

[COMMANDE DE VÉRIFICATION TDPO — À COMPLÉTER SELON VERSION]**

TEST — ne pas exécuter sans validation DBA

[COMMANDE RMAN / SBT DE TEST — À COMPLÉTER PAR DBA]**

Résultat attendu

TDPO est chargé par l’environnement Oracle/RMAN, les paramètres de connexion sont cohérents et le test autorisé se termine avec un résultat confirmé dans les journaux.

Points de contrôle

• Vérifier les versions exactes des composants et les chemins de bibliothèques.
• Confirmer que RMAN utilise le bon Oracle Home et le bon fichier de paramètres.
• Contrôler les journaux TDPO, client et RMAN en corrélant les horodatages.
• Une sauvegarde réussie doit être confirmée côté Spectrum Protect ; la seule réussite d’une commande RMAN ne suffit pas à prouver la disponibilité du média.

Gestion des anomalies

• Figure 17 — Résultat du déploiement TDPO

CHAPITRE 10 — Vérification des sauvegardes des machines virtuelles via TDP for VE

Tivoli Data Protection for Virtual Environments (TDP for VE) protège les machines virtuelles VMware en s’appuyant sur les interfaces VMware et les composants Spectrum Protect prévus par l’architecture. Les composants exacts, les méthodes de sauvegarde, les proxys et les vues de supervision dépendent de la version et du déploiement local.

Objectif

Vérifier que les machines virtuelles attendues sont protégées, que leur dernière sauvegarde est récente et que des points de restauration sont disponibles.

Prérequis

• Accès à Operations Center et aux interfaces VMware/TDP for VE autorisées.
• Connaître le datacenter, vCenter, les groupes/VM attendus et leur fréquence de sauvegarde.
• Connaître le RPO et la fenêtre de sauvegarde applicables.

Étapes d’exécution

1. Identifier le datacenter VMware concerné et le vCenter associé.
2. Accéder à la vue TDP for VE ou à l’interface de gestion prévue dans l’environnement.
3. Filtrer la liste des machines virtuelles protégées et vérifier que toutes les VM du périmètre sont présentes.
4. Pour chaque VM prioritaire, relever la dernière sauvegarde, le type d’opération, son statut et son horodatage.
5. Examiner les opérations en erreur et consulter les détails/journaux associés.
6. Vérifier la présence et la rétention des points de restauration selon la politique.
7. Pour valider la restaurabilité, réaliser périodiquement un test de restauration contrôlé selon un plan approuvé ; ne pas assimiler un job réussi à un test de restauration.

Commandes

EMPLACEMENT RÉSERVÉ

[COMMANDES TDP FOR VE — À COMPLÉTER APRÈS VALIDATION DE LA VERSION ET DE L’ARCHITECTURE]**

RÉFÉRENCE INTERNE

[VUE / RAPPORT LOCAL — À COMPLÉTER]**

Résultat attendu

Les VM attendues sont visibles, leur dernière sauvegarde respecte le RPO, les opérations en échec sont qualifiées et les points de restauration attendus sont disponibles. La restaurabilité est confirmée séparément par des tests de restauration documentés.

Points de contrôle

• Vérifier l’identité du vCenter et du datacenter avant d’interpréter les résultats.
• Comparer la liste des VM protégées à l’inventaire VMware et au périmètre contractuel.
• Vérifier l’horodatage, le statut final et les éventuels avertissements.
• Contrôler la rétention et l’existence des points de restauration.
• Planifier des tests de restauration périodiques avec validation applicative.

Gestion des anomalies

• VM absente : vérifier l’inventaire, les règles de protection et les droits vCenter.
• Échec de snapshot ou de transport : examiner les événements VMware, les ressources proxy et les journaux TDP for VE.
• Point de restauration absent : vérifier la rétention, les erreurs de sauvegarde et l’état du stockage.
• Restauration échouée : ouvrir un incident prioritaire et préserver les journaux ; ne pas supprimer les points existants.

Captures d’écran

|

> **[EMPLACEMENT DE CAPTURE — Figure 18 — Vue TDP for VE]**
> |

| — |

Figure 18 — Vue TDP for VE

|

> **[EMPLACEMENT DE CAPTURE — Figure 19 — Liste des VM sauvegardées]**
> |

| — |

Figure 19 — Liste des VM sauvegardées

|

> **[EMPLACEMENT DE CAPTURE — Figure 20 — Historique des sauvegardes VMware]**
> |

| — |

Figure 20 — Historique des sauvegardes VMware

Les captures d’écran et les commandes exactes de l’environnement seront ajoutées après validation de la version de TDP for VE et de l’architecture VMware.

CHAPITRE A — Tableau récapitulatif des commandes TSM

Le tableau ci-dessous ne recense que les commandes explicitement fournies ou les exemples génériques identifiés dans ce guide. Toute commande marquée « à compléter » doit être validée dans la documentation IBM correspondant à la version installée avant exécution.

| Catégorie | Commande / emplacement | Nature | Statut |

| — | — | — | — |

| Supervision événements | query event * * | Consultation | Commande fournie ; périmètre à préciser |

| Librairie / bandes | query libv LTO7_PROD | Consultation | Commande fournie ; nom de librairie à confirmer |

| Réplication | [COMMANDE DE RÉPLICATION À DÉFINIR]**
| Modifiante si déclenchement | À compléter |

| Storage pools | [COMMANDE DE CONSULTATION STGPOOL À VALIDER]**
| Consultation | À compléter |

| Volumes | [COMMANDE DE CONSULTATION VOLUMES À VALIDER]**
| Consultation | À compléter |

| Check-in | [COMMANDE CHECK-IN 1 — À COMPLÉTER]**
| Modifiante | À compléter |

| Check-in | [COMMANDE CHECK-IN 2 — À COMPLÉTER]**
| Modifiante | À compléter |

| DRM | [COMMANDE DE CONSULTATION DRM — À COMPLÉTER]**
| Consultation | À compléter |

| Nœuds | register node <NOM_NOEUD> <MOT_DE_PASSE> domain=<DOMAINE> | Modifiante | Exemple générique à valider |

| Schedules | define association <DOMAINE> <SCHEDULE> <NOM_NOEUD> | Modifiante | Exemple générique à valider |

| VMware / TDP for VE | [COMMANDES À COMPLÉTER]**
| Selon commande | À compléter |

A.1 Règles avant exécution

• Vérifier la version du serveur et consulter la syntaxe IBM correspondant à cette version.
• Identifier le serveur sur lequel la commande sera exécutée.
• Classer l’action : consultation, modification de configuration, déplacement de média ou déclenchement d’un traitement.
• Pour une commande modifiante, obtenir l’approbation, vérifier la fenêtre et préparer le retour arrière.
• Copier/coller uniquement une commande relue ; contrôler les variables et les noms d’objets.

CHAPITRE B — Checklist d’exploitation quotidienne

Cocher les contrôles réalisés et consigner les écarts dans le suivi des anomalies.

| Fait | Contrôle | Critère / action |

| — | — | — |

| ☐ | Santé des serveurs TSM | Serveurs disponibles ; alertes critiques qualifiées. |

| ☐ | Nœuds prioritaires | ALGU3_ORA et autres nœuds critiques visibles et dans l’état attendu. |

| ☐ | Sauvegardes planifiées | Événements attendus terminés ; manqués/échoués analysés. |

| ☐ | Activités en cours | Aucune activité anormalement longue ou bloquée non suivie. |

| ☐ | Réplication intersites | Dernier cycle conforme au RPO ; erreurs et backlog suivis. |

| ☐ | COPYPOOL | Pool disponible ; capacité et volumes cohérents. |

| ☐ | Librairie LTO7_PROD | Inventaire consulté ; volumes indisponibles ou incohérents analysés. |

| ☐ | Cartouches DRM | États VAULTRETRIEVE et mouvements physiques rapprochés. |

| ☐ | Capacité / seuils | Tendances d’occupation et alertes de capacité examinées. |

| ☐ | Incidents et escalades | Tickets ouverts, propriétaires et prochaines actions renseignés. |

| Date | Opérateur | Serveur(s) contrôlé(s) | Anomalies / ticket | Visa |