-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u8
-- http://www.phpmyadmin.net
--
-- Hostiteľ: localhost
-- Vygenerované: Ned 10.Dec 2017, 11:56
-- Verzia serveru: 5.5.58
-- Verzia PHP: 5.6.29-0+deb8u1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáza: `michalik38`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `keywords`
--

CREATE TABLE IF NOT EXISTS `keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'primarny kluc tabulky',
  `word` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tabulka ktora obsahuje klucove slova' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `keywords_questions`
--

CREATE TABLE IF NOT EXISTS `keywords_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_keyword_id` (`keyword_id`),
  KEY `fk_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `pictures`
--

CREATE TABLE IF NOT EXISTS `pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` text COLLATE utf8_bin NOT NULL COMMENT 'obrazok zakomentovany base64',
  `question_id` int(11) NOT NULL COMMENT 'cudzi kluc odkazujuci na otazku v tabulke questions',
  PRIMARY KEY (`id`),
  KEY `fk_question_id` (`question_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- Sťahujem dáta pre tabuľku `pictures`
--

INSERT INTO `pictures` (`id`, `picture`, `question_id`) VALUES
(1, 'iVBORw0KGgoAAAANSUhEUgAAAW8AAAFCCAIAAACxbMurAAAYkElEQVR4nO3da2xT5+HH8eccX5I4\nsQNJGqCQZSsQQoEAKx0b3QZlQ1OlDWmwS9lWqmlrX2wvKlXTXkxq31SaNglpK221F5PYhQ5tXaVJ\na6tNojBaULmsUCgtsKbcoYFAHBw7vpzr/8XJ34bgXDn2c3jy/bxAxj5OfvKxf3me59jHmuu6AgDu\nmC47AABF0CYA/EGbAPAHbQLAH7QJAH/QJgD8QZsA8AdtAsAf4WH/nzdvnhAiFArJCAMg0K5du/bS\nSy9t2rSp7K3D28QwjKeffjoWi1U+GIC7zF//+td8Pj/SrcPbxPPaa68dPHgwOCMU0zQ3b9785z//\nORKJyM5SYlnWmjVrjh49mslkZGcpcV23ra0tHo+X3euFQsE0zduvNwyj7PWWZZW9fthvdBxn9G1M\n03z88cdffvnlcLj8U04K0zQ3bNjwxhtvjJm/mhzHWbx4cTKZvHLliuwsJZZl/eIXvxh9m/K7NpVK\n/fznP1+/fn0FUk3GM888YxhGLBZ78803ZWcp2bZt23vvvWeaZiwWW7Rokew4Qw4ePNjX13fmzJmO\njo5oNDrs1pqamrJ/JHRdn9D1E5JMJlOplGmaiUTiX//61x3+NB/95je/yWQy4XB4586dsrOU/OMf\n//jb3/6WTqffeust2VlKvvKVr4zZuSP+oZgxY0ZHR4ffkSYpkUgIIXRdD04kIURLS4sQQtf1+fPn\nf/3rX5cdZ8j58+fT6XQkEtm4caP3uEnX3d29a9cuIUQoFArUHmxqaspkMpqmBSrVjBkzhBBBS6Xr\nYx+x4ZgOAH/QJgD8QZsoiHPWQAraBIA/aBMFua6raZrsFJhyaBMFMdOBFLSJgmgTSEGbKIg2gRS0\niYJYN4EUtImCGJtACtpEQbQJpKBNAPiDNlEQYxNIQZsoiFVYSEGbKIixCaSgTRREm0AK2gSAP2gT\nBTE2gRS0iYJYhYUUtImCXNdleILqo00UxNgEUtAmamJsguqjTRRElUAK2gSAP2gTAP6gTdTEKiyq\njzZREEeIIQVtAsAftImamOmg+mgTAP6gTQD4gzYB4A/aREEc04EUtImaWIVF9dEmAPxBmwDwB22i\nINZNIAVtoibWTVB9tImCdJ3dCgl42ikoFArJjoCpiDZRkK7rrJug+mgTBTE2gRS0iYIYm0AK2kRB\njE0gBW2ioFAoxNgE1Rce6YY9e/bk8/lqRhlFd3f34sWLC4XC73//e9lZSg4ePCiEsCzrvffeO3fu\nnOw4Q3p7e6dNm6Zp2vPPP1+c8oRCoeJhY03Tiu9Gqc4oxjCMcDgshMjlcoHag0ePHm1qajJNM1Cp\n3nnnHSGEbduBSlUoFMbcpnyb1NbWbtu2bdu2bX5HmrzFixdfuXLlySeflB3kFt/4xjdc102lUqlU\nathN4XDYewkNo+t6JBIpe300Gh3912maNuY2LS0tixYtWr16dW9vbyaTGRwczGQyqVQql8t5G+Ry\nOcuyhBCmaabT6dFHMbZtm6Z5+/WO44x0vWEYI/20S5cuBW0Pbt68OZVKBS3VQw89lM1mg5ZqTOXb\nJJ/Pt7S0lH0xSOE9cePxeH19vewsJYZhFAoF0zS9scCwW28eAgy7vuxP0zTNcZzbrx/2aveKwFN2\n+2w2u3bt2meeeSYej5f9LRNNVbb7hBAj9VrZVF7sRCIRi8XK3ksKwzAcx6mpqVm2bJnsLCW9vb3Z\nbDafzz/00EOys5QcP358zG1G7IvW1tannnrK1zyTdPXq1VdffVUIEY/H161bt2rVKtmJhmzZskUI\nEYvFOjo6NmzYIDvOkF/+8peO49TX1z/99NOJREJ2HCGE6O7u3rVrlxCisbFx/fr1XV1dshMJIYRp\nmlu3bhVCxOPxffv2yY5T8sc//nHr1q2RSCRQqdrb28fchlVYBbEECyloEwXRJpCCNlFQ2ZULoNJo\nEwXZti07AqYi2kQ13rEhzm+C6qNNFHTzUWSgamgTBTHTgRS0iWo0TaNNIAVtoiDWTSAFbaIaxiaQ\nhTZREKuwkII2URDvXoMUtIlqRvosMlBptImCWDeBFLSJgmzb5pgOqo82UQ3HdCALbaIg1k0gBW2i\nGsYmkIU2URBjE0hBmyiINoEUtIlqmOlAFtpEQXzqD1LQJgqybZsTTaP6aBPV8M56yEKbKIg2gRS0\niYJYN4EUtIlqOKYDWWgTBTHTgRS0iYIcx+GYDqqPNlENx3QgC22iINZNIAVtohrGJpCFNlEQR4gh\nBW2iIFZhIQVtohpmOpCFNlEQbQIpaBMF0SaQgjZRDTMdyEKbKIhVWEhBm6hG0zSqBFLQJgpipgMp\naBMF0SaQgjZRDauwkIU2UZDruiydoPpoEwVRJZAiPNINpmkePny4mlFGkkqlipfPnz9fU1MjMczN\nihOKK1euBOSxEkIMDAx4F44dOxaLxeSG8fT09BQvnz592jRNiWGKLMuSHUE15dskFArZtr1///4q\npxnJ9evXhRADAwN9fX3BSWVZlq7rhULBcZzgpIpEIkKIQqFw7Ngx2VlKrl69KoQYGBi4fPny5cuX\nZccZks1mhRCZTGbt2rWys5Rcv369trZWCBGoVP39/WNuU75NVq9effPfkyBob2//3ve+JzvFcPfe\ne++CBQtyuZzsILd4+OGHZUcoo729/fHHH9f1MpPraDQaDpd5KobD4UoPRRsaGhKJRKDGKfPnz7/n\nnnsMw7h5VC7d/Pnz6+rqRt+mfJvs2bPn1KlTwZlTZDKZTZs2/eUvf2lubpadpSSbzT7wwANHjx6N\nRqPBOZ9IoVDwBgKBomnaT3/60xdffNGXn6br+nienHV1dcX9UltbGwqFhm3guu4jjzzyyiuvxOPx\n4OzBfD7f1taWTCYbGhpkZyk5e/ZsR0fH6NuUbxPHcRobG7/1rW9VINWEJZPJd955RwjR2NjY1dXV\n1dUlO9GQV155xXXdWCw2c+bM4AwHXn31Va9Nnnrqqfr6etlxhBDi/PnzO3bs8EYlS5cuHbZuYtu2\naZqappV9PU/i+glle/311+PxeEdHx8qVKyd0x8r5+9//7jhOKBR6//33ZWcpaW9vH3ObEVdhw+Hw\neO5fBd4c0tPc3ByQVOKmJ24ikQhOquLDNWfOnEQiITeMxzAM13W9NhkcHPzJT35y82s+HA5Ho1FZ\n2V544YVUKjV9+vTg7EFv5etuNGKbAH7xeqS4YhKLxYIzrYCPeL8JKs5bsCi7/gqVsINRccPGJlAV\nOxgV5/UIsxvl0SaoOMYmUwQ7GBXnrZswNlEebYKKY2wyRbCDUXG0yRTBDkbFcYR4imAHo+IYm0wR\n7GBUHKuwUwRtgopjbDJFsINRcbquj/SRX6iENkHFeW0iOwUqjjZBxYVCIaY5UwH7GBWn6zptMhWw\nj1ENZU/7CsXQJqgG2mQqoE1QDXfv2QkxfrQJqoGxyVRAm6AaaJOpgDZBNdAmUwFtgmqgTaYC2gTV\ncPv37AUEb4TxEQ8lqoFjOlMBbQLAH7QJqsEwDNkRUHG0Caph2DeZQ0m0CaqBsclUQJugGhibTAW0\nCaqBNpkKaBNUAzOdqYA2QcW5rkubTAW0CSrOtm3HcWSnQMXRJqg42mSKoE1QcbZtCyEoFOXRJqg4\ny7IEbTIF0CaoOG9s4v0bKI7j8EU/PqJNUHGBnek4jsMZCXzEQ4mKC2yb2LYd2BOv3I1oE1RcYNdN\nLMvipHA+ok1QcYFdNzEMIxqNyk6hDtoEFRfYsYlpmpwUzke0CSousOsmpmkyNvHRiJNGx3GuX79e\nzSgj6e/vL17OZDIBSXWzXC4XnFTFT+v29fUF5NMxyWRS0zSvTerq6n7729/efGs4HI5Go5ZlFZNH\no9HickahULBtu7a2dtjBl7q6umEHd2+/pra2NhQKhUKhmpqa4gaRSKS5uXn69OmxWKxQKHhtEqjn\nlWVZXuC7Tvk20TTNNM0dO3ZUOc1I0um0EGJwcPDUqVOnTp2SHWeIZVmaphUKhb6+vuA8VoVCwbvw\nq1/9Sm6Sm+m67o1Qjh8/Pv57aZoWi8XKXl9bW1v8b3HUo+v6zTMX73rXdTVNC4fDruuGQiFN01zX\ndRzHdV0hxJo1a3K53MWLF4OzB73nleM4P/rRj2RnKRkYGBhzm/Jt8vDDD/f09Pid5460t7d/97vf\nlZ1iuHvvvbezszOXy8kOchdoa2t78sknR7pV07S6urqRbvXGLyPd6o1BRrq1bB95BgcHY7HYtGnT\nvJWd4LjnnnsMw0ilUrKDlHznO98ZZQd5yrfJ3r1733///eAMtzKZzA9+8IPt27c3NTXJzlKSz+dX\nrlx55MiRQL1nwbKsq1evxuPxRCIhO0vJwMDA5s2bt2/fHo/HZWcpKRQK69evf+211+rr62VnKTEM\n47777ksmk9lsVnaWkmQy2dHRMfo25dvENM3GxsYVK1ZUINWEZTKZS5cuCSGmT58+e/bsz3zmM7IT\nDfnvf/9rWVZdXV1NTc3SpUtlxxmyb98+IUR9ff2KFStung5IdO3aNW/xa9q0afPnz581a5bsREII\nYdv2yZMnXdeNx+NNTU2dnZ2yEw05cOCAYRiu64bD4c9//vOy4wghxMWLF8eziD7iKmxNTc3atWt9\njTRJV69evXjxond54cKFq1atkpun6MiRI96F9vb2gDxWQoiTJ09evnxZCPHFL34xIMOT7u7uXbt2\nCSE0TVuyZElXV5fsREIIYZrmyZMnvcvz588Pzh4sLi3NmjUrIKnefffds2fPjrkZR4gB+IM2AeAP\n2gSAP2gTAP6gTQD4gzYB4A/aBIA/aBMA/qBNAPiDNgHgD9oEgD9oEwD+oE0A+IM2AeAP2gSAP2gT\nAP6gTQD4gzYB4A/aBIA/aBMA/qBNAPiDNgHgD9pETcO+kReoAtpEQd5X7cpOgSmHNlGQpmmMTVB9\ntImCaBNIQZsoiJkOpKBNAPiDNlEQMx1IQZsoiCqBFLSJgmgTSEGbKIg2gRS0iYJYN4EUtImCOEIM\nKWgTBTEwgRS0CQB/0CYKYmwCKWgTBbEKCyloEwVRJZCCNlFQKBSSHQFTEW2ioFAoxBFiVB9toiDG\nJpCCNlEQYxNIQZsoiDaBFLSJgsLhsOwImIpGfNoNDg7++te/rmaUkRT/zBYKhf/85z979+6Vm6fI\nsiwhhGEYJ06c6O7ulh1nSDabraurc11369atxQ/sFB/DkZZUNE3T9Ur9aXEcxztonc/n//3vf+/c\nubNCv2hCXNd1HEcIUSgUDh06dOTIEdmJhhQKhdbWVtu2L1++HJDXoG3bhUJhzM3Kt8nSpUsD9Z4F\nTdNaW1u7urps25ad5RaLFi2KxWLJZFJ2kFu0t7cvW7YsnU5ns1nDMAqFgm3b2WzWcZyBgYGyd8nl\ncqZpVi5ScQ96L+DgaGtre+CBBwYHB2UHuUVnZ2cmk7l06ZLsICW6rkej0dG3Kd8mPT0958+fD86h\nAcMwHnzwwf/97381NTWys5RYljVnzpwzZ86k02nZWUps2z59+vSbb75ZW1srO0uJaZrB3IOLFi36\n6KOPAtVxtm03NDTcuHGjp6dHdpaSfD7vDcZHUb5Nent7n3vuuccee6wCqSbjiSeeyOVyQohIJDJz\n5kzZcYZcunTp+vXr6XTaMIy5c+fKjjPkgw8+SCaTM2bMmDFjxph/TKrjxo0boVDI24MNDQ1NTU2y\nEwkhhG3b/f393u4LhUKf+tSnZCca8vHHH/f09KTT6Uwms3DhQtlxhBDi2rVr+Xx+zM69y5brvvCF\nL6xatUp2iiFbtmzxLixevHjDhg1ywxS99NJLyWRS07SNGzcmEgnZcYQQoru7e9euXUIITdNWr17d\n1dUlO5EQQpim+bvf/c67vGLFinXr1snNU/T88897F+bOnfv9739fbhjPu++++/rrr4+5Gcd0APiD\nNgHgD9oEgD9oEwD+oE0A+IM2AeAP2gSAP2gTAP6gTQD4gzYB4A/aBIA/aBMA/qBNAPiDNgHgD9oE\ngD9oEwD+oE0A+IM2AeAP2gSAP2gTAP6gTQD4gzYB4A/aBIA/aBMA/qBNAPiDNgHgD9oEgD9oEwD+\noE0A+IM2AeAP2gSAP2gTAP6gTQD4gzYB4A/aBIA/aBMA/qBNAPiDNgHgD9oEgD9oEwD+oE0A+IM2\nAeAP2gSAP2gTAP4Iyw4wMd3d3bZty04xpJjk8uXLe/fulRumqL+/37tw8ODB2tpauWE8vb293gXX\ndU+cOJFKpeTm8dz8RDpz5kxw9mAul6upqRFC9Pb2BiTVhQsXxrNZ+TYJh8PPPffciy++6Gukybtw\n4cLGjRtTqVR/f//hw4dlxxliGEYoFCoUCrW1tcFJFQ6HhRD5fP7DDz+UnaWkt7d31apV6XT64sWL\nFy9elB1nSDqdFkJkMpmGhobg7EHHcSKRiKZpNTU1wUnlPVajK98ma9eu7evr8zvP5K1ataqtre2J\nJ56QHWS41tbWrq6uQqEgO8gt4vH4nDlzJnQX0zRN07z9esuyDMMY/b62befz+dG3cV23paXlxz/+\n8YRSVcGsWbNmzpxpWZbsILeYPn26aZqZTEZ2kFvU1dWNvkH5Ntm5c+cnn3zS0tJSgUiTceHChW9+\n85vbt2+///77ZWcpuXLlyoIFC44dO+YNBwLCNM36+vq+vr4xpzmu67qu613WdT0UCt2+jaZpmqaV\nvftI15eVzWYfffTR7du3JxKJ8d+r0nK53COPPPLGG2/U19fLzlJimubs2bOTyeTMmTNlZyk5ceLE\ns88+O/o25V8Grus+++yzjz32WAVSTYY3Kpk+ffr+/ftlZynZsmXLzp076+rq2travva1r8mOM+Tl\nl1/O5/O1tbU//OEP4/G47DhCCHH27FlvxN7Y2LhmzZrOzk7ZiYQQwjTNHTt2CCEaGhoWLVr0pS99\nSXaiIX/6059c1w2Hw4F6tre3t4+5TYD+qN696urqgjOOi0Qi3ryjubk5IAOB4sKwECKRSATksbp5\nZtfQ0BCQVOL/V77uRhwhBuAP2gSAP2gTBRXXVoFqok0U5LruhA64AL6gTRTE2ARS0CYKok0gBW0C\nwB+0iYJYN4EUtImCmOlACtpEQbQJpKBNFORLm8RisXg8rus8QzBed+snAlAJoVCoo6Ojs7OzpaXF\ntm3vs2eZTObjjz/+4IMPcrmc7IAINNpEQZNbhZ01a9ZXv/rVSCTifeqs+NmzeDze1dXV1dV16NCh\n48eP+5wVCqFNFOS67kRnKPPmzfvyl7880qdXvVOfPPjgg83NzXv27LnzhFASs2IFTXTdpLW1dZQq\nKQqHw/fdd9/y5cvvIBpURpsoaEJtouv6unXrxnlOjXA4vHz58oCcNgVBQ5tMdXPnzo1Go+PfXtf1\nz33uc5XLg7sXbaKgCY1N7r///kgkMv7tdV1vb2+/e88PhsqhTRQ0oWM6kziDoW3bzc3NE70XlEeb\nKOjmk9GPLhqNTu4TPYE6yTsCgjZR0PjHJrquT+6Ns7xHFrfjOaGmcXZEPp+f3NhkcHBwEveC2mgT\nBU1o3eTGjRsT/fmhUChQXwWJgKBNFDShyctHH3000e/NvHbt2phfJ4opiDZR0ITa5NSpU47jjH97\ny7IOHTo08VBQH22ioAm1iWEYe/fuHefwxDTNM2fOXLlyZbLRoDLaRE0TKpTTp0+fOHFizEKxLOvG\njRtvv/32nUWDsnhHo4ImcUaCAwcOpNPplStX6rpe9uivZVlnz559++23JzQtwpRCmyhocm8h+fDD\nD8+cObNixYp58+ZpmlZsjXA43NPTc+DAAY7jYHS0iYLG/17YYXK53N69e/ft29fU1NTQ0KBpWjab\n7e/vN03T95BQD22ioDs8L6zrun19fYxEMFGswiqIc9ZDCtoEgD9oEwUxNoEUtImCaBNIQZsoiDaB\nFLSJgiZ9hBi4E7QJAH/QJgqa3Hf9AXeINlEQMx1IQZsoiDaBFLSJgpjpQAraBIA/aBM1MdNB9Y34\nGeJz584dPny4mlFGcf369dmzZxuGEZxIQohLly4JIWzbPn/+/AsvvCA7zhDvuyls2/7DH/4QkG+9\nsW3b+6ZR0zR379791ltvyU4khBCu63pfwGxZ1vHjx0+dOiU70RDLsmpqaoQQgXq2j+e84uXbZOnS\npbt37969e7ffkSZv+fLlnZ2dP/vZz2QHKXFd97Of/Wx9fX1/f7/sLCXNzc1z5841TTNQSyeaprW2\ntnZ2dsoOcgvXddva2pYtW5bL5WRnKXFdd8GCBZlMJlDP9oULF3rlO4rybbJkyZIlS5ZUINIdefTR\nR2VHKCNor5Ag27Rpk+wIZXz605+WHUERZdpk//79Y5YQgCnok08+GeVWbdhy3T//+c9z585VNhGA\nu9a3v/3tWbNmlb1peJsAwOQEYs0fgAJoEwD+oE0A+IM2AeAP2gSAP2gTAP6gTQD4gzYB4I//A5lY\ns5CgqZlLAAAAAElFTkSuQmCC', 6),
(2, 'iVBORw0KGgoAAAANSUhEUgAAAFMAAABSCAYAAAAo7uilAAAWVUlEQVR4Ae3cdbS1RdUA8Hmlu0NC\nGlQapEG6u2GxAOlSupEOpVNB6ZYQVEJpQelulO7ukjzf+s3HPt/c533Oc8597335w49Z67lTe/bM\n7Nkzs2POHdJqtVrpuzAoFBgRlpKeQ4YMGRTE/+1IgmYlvTIxg6Bff/11Kiv/2wkykPkhJlqNMMII\nbTRtzlS5zTbbpAcffLBd+V2imQJrrLFG2nPPPdtAmZjBjf/+97/T3Xff3a4cHgl9xRYZHvi/TZw/\n+clP+nTX3uZKg6g77rhjWmqppTLg559/nl588cU0xhhjpEknnbRP4/5mEPGII45Ic8wxR1pmmWVy\n8+iziisI/tprr6UPP/wwff/7309jjz12TwtxyimnpHHHHTett956VbTDlP/ggw/SqKOOmkYZZZTc\n/xlnnJEuu+yyoXC1iWlSMbHZZ589Lb/88umZZ55Ju+++e45HHHHEtM466ySEHnnkkYdC1EuBM/mc\nc85Js8wyS1phhRVyf9Fn2R7cp59+mg477LB03XXXpf/85z+ZOPvtt19aYokl0ve+970SvJ22AL6r\nrroqTTLJJO0+2gD9SASul156KR9/BxxwQJp77rkzhhtvvDHH1bHXjioQXXzxxWmxxRZLt956a/rj\nH/+Y/va3v6Wnn366H0MaGhShfN3CQw89lBw7l19+ebr99tvTDjvskH7961+njz76qFvTTFBzGEgw\nxltuuSVtu+226YEHHmgzGgJ2wt3mzGrHGu28884JR9pmzz//fBpvvPHSBBNMUAXtV37jjTdOU001\nVdc2zqNzzz23vQvmnHPO9OWXXybHTrew1lprpdFHH70bWGP9xx9/nHDg3nvvnXbdddeOBCyRdCQm\nINvZBNxY11xzTdpkk03SWGONlTkLsatsXiKuS4NfaaWV6qr6lIGziD7BGP7yl7+k+eefPy9oH+BK\nRltHwUCDee6///7pk08+yYTsdLSU/dRu85JI5Khf/epX6e9//3t68skn2wdvJ1YvkXdLl/10grXd\nHDe2vZ3SNKle8HXqp1oOl7mLe8VbS8wgVGwp23vKKadMCy64YLr33nvzSvXaQTlIeD/77LPMaWV5\nNR3944qTTjop/eMf/0iHH354mnjiiRsnpp3PuL/44osq2uGeryWmXg3GTU4EQAAH//3335+cXU3c\n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\nGv+C9pQAAAAASUVORK5CYII=', 6);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id otazky',
  `question` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'znenie otazky',
  `points` int(11) NOT NULL COMMENT 'pocet bodov',
  `practical` tinyint(1) NOT NULL COMMENT 'true - prakticka / false - nie prakticka',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

--
-- Sťahujem dáta pre tabuľku `questions`
--

INSERT INTO `questions` (`id`, `question`, `points`, `practical`) VALUES
(1, 'Matica opakovaných výskytov. Ako sa tvorí a aké informácie sa z nej dajú odvodiť?', 5, 0),
(2, 'Popíšte Harrisov detektor rohov. Voči ktorým transformáciám ja a nie je invariantný. Prečo?', 10, 0),
(3, 'Popíšte Houghovu transformáciu pre priamky ľubovoľného smeru.', 10, 0),
(4, 'Popíšte metódu SIFT (detektor a deskriptor).', 10, 0),
(5, 'Popíšte Ittiho model vizuálnej pozornosti.', 15, 0),
(6, 'a) Vyznačtete 8-susednú hranicu oblasti na obrázku A. Napíšte jej reťazcový (Freemanov) kód, začínajúci vo vyznačenom bode, ktorý postupuje v smere hodinových ručičiek. Susedov označujte podľa obrázka B.\r\nb) Cyklicky posuňte kód tak, aby vzniklo najmenš', 10, 0);

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `keywords_questions`
--
ALTER TABLE `keywords_questions`
  ADD CONSTRAINT `fk_questions_id` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `fk_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`);

--
-- Obmedzenie pre tabuľku `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `pictures_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
